
class Movie {
    constructor(id, title, releaseYear, ytId, thumbnailUrl, filmingLocation, synopsis = '') {
        this.id = id;
        this.title = title;
        this.releaseYear = releaseYear;
        this.ytId = ytId;
        this.thumbnailUrl = thumbnailUrl;
        this.synopsis = synopsis;
        this.filmingLocation = filmingLocation;
    }
}

class Actor {
    constructor(id, firstname, lastname) {
        this.id = id;
        this.firstname = firstname;
        this.lastname = lastname;
    }
};


function loadCastForMovie(movieId) {

    console.log('loading for movie: ', movieId);

    let actorsPromise = new Promise(function (resolve, reject) {
        $.ajax({
            url: 'rest_controller.php?actors_for_movie=ok&id_movie=' + movieId,
            success: function (date) {
                date = JSON.parse(date);
                resolve(date);
            }
        });
    });

    return actorsPromise;



}


function loadHomePageMovies(lang) {
    return loadMovies(lang); 

}

function loadMovies(lang) {
    console.log('loading movies for language: ', lang);

    var promiseMovies = new Promise(function (resolve, reject) {
        switch (lang) {
            case "ro":
                $.ajax({
                    url: 'rest_controller.php?movies=1&lang=ro',
                    success: function (date) {
                        date = JSON.parse(date);
                        console.log('parsing: ', date);
                        for(let d of date){
                            d.filmingLocation = JSON.parse(d.filmingLocation);
                        }
                        
                        resolve(date);
                    }
                });
                break;
            case "en":
                $.ajax({
                    url: 'rest_controller.php?movies=1&lang=en',
                    success: function (date) {
                        date = JSON.parse(date);
                        console.log('parsing: ', date);
                        for(let d of date){
                            d.filmingLocation = JSON.parse(d.filmingLocation);
                        }
                        resolve(date);
                    }
                });
                break;
            default:
                $.ajax({
                    url: 'rest_controller.php?movies=1&lang=en',
                    success: function (date) {
                        date = JSON.parse(date);
                        console.log('parsing: ', date);
                        for(let d of date){
                            d.filmingLocation = JSON.parse(d.filmingLocation);
                        }
                        resolve(date);
                    }
                });
                break;
        }
    });
    return promiseMovies;
    
}

function displayMovieDiv(movie) {
    let pageContent = `<div id="tabs-${movie.id}">
        <ul>
            <li><a href="#tabs-1-${movie.id}">Synopsis ${movie.title}</a></li>
            <li><a href="#tabs-2-${movie.id}"  class="cast-link" data-id="${movie.id}">Cast</a></li>
            <li><a href="#tabs-3-${movie.id}">Filming locations</a></li>
            <li><a href="#tabs-4-${movie.id}">Trailer</a></li>
        </ul>
        <div id="tabs-1-${movie.id}" style="min-height: 400px;">
            <p>
                <h3> ${movie.title} </h3>
                <p>
                <img style="float: left;" src="${movie.thumbnailUrl}" alt="${movie.title}">
                    ${movie.synopsis}
                </p>
            </p>
        </div>
        <div id="tabs-2-${movie.id}">
            <p id="tabs-paragraph-2-${movie.id}">
                <ul>...</ul>
            </p>
        </div>
        <div id="tabs-3-${movie.id}">
            <div id="map-${movie.id}" style="height: 300px; width: 400px;"></div>
            
        </div>
        <div id="tabs-4-${movie.id}" style="height: 400px; width: 300px;">
            <iframe 
                width="90%" 
                height="70%" 
                src="https://www.youtube.com/embed/${movie.ytId}" 
                frameborder="0" 
                allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
            </iframe>
        </div>
        </div>
        `;


    return pageContent;
}


function adminPage(){
    

    var promise = new Promise(function(resolve, reject){
        $.ajax({
            url : 'rest_controller.php?is_logged_in=1',
            success : function(data){
                data = JSON.parse(data);
                resolve(data);
            }
        });
    });
    

    function renderUserTableRow(user){
        return `<tr><td>${user.id}</td><td>${user.email}</td><td>${user.is_online}</td></tr>`;
    }

    promise.then(function(data){
        // {"status":"logged_in","user_type":"ADMIN"}
        let isAdmin = data.user_type == 'ADMIN';
        if(!isAdmin){
            $('#page-content').html(`<h2>Admin section</h2>
             <span style="color: red;">You are not authorized to view this page</span>
             
            `);
        }else{

            var usersPromise = new Promise(function(resolve, reject){
                $.ajax({
                    url : 'rest_controller.php?users=1',
                    success : function(dataUsers){
                        resolve(JSON.parse(dataUsers));
                    }
                });
            });

            usersPromise.then(function(dataUsers){
                var adminPageContent = `<h2>Admin section</h2>
                Welcome, ${data.email} <br>
                <table border="1">
                    <thead>
                        <tr><th>ID</th><th>Email</th><th>Is Logged In</th></tr>
                    </thead>
                    <tbody>
                
            `;
                for(let user of dataUsers){
                    if(user.is_online == 1){
                        adminPageContent += renderUserTableRow(user);
                    }
                }
                adminPageContent += '</tbody></table>';
                adminPageContent += `
                <table border="1">
                <thead>
                    <tr><th>ID</th><th>PAGE NAME</th><th>USER ID</th><th>DURATION</th></tr>

                </thead>
                <tbody id="times">

                </tbody>
             </table>
                `;
                $('#page-content').html(adminPageContent);

                $.ajax({
                    url : 'rest_controller.php?page_time_get',
                    success : function (data){
                        data = JSON.parse(data);
                        for(let time of data){
                        $('#times').append(`
                            <tr>
                            <td>${time.id}</td>
                            <td>${time.page_name}</td>
                            <td>${time.user_id}</td>
                            <td>${time.total_time}</td>
                            </tr>
                        `);
                        }
                        
                    }
                });
            });
           

            
        }
    });
    
}

function refreshPage(lang) {
    // let movies = loadMovies(lang);
    let movies = [];
    //alert('REFRESH PAGE');

    loadMovies(lang).then(function (date) {
        console.log('movies are: ', date);
        movies = date;
        $('#page-content').html(`
        <h2>Movies page</h2>
        <div id="all-movies">

        </div>
    `);

        for (let movie of movies) {
            let movieDiv = displayMovieDiv(movie);
            $('#all-movies').append(movieDiv);
        }

        for (let movie of movies) {
            initMap(movie);
        }

        for (let movie of movies) {
            $("#tabs-" + movie.id).tabs();
            let selector = `#tabs-2-${movie.id}`;
            console.log('registering click event for: ', selector);
        }

        $('.cast-link').click(function () {

            let id = $(this).attr('data-id');
            let selector = `#tabs-paragraph-2-${id}`;
            console.log('click on cast tab with id: ' + id);

            let cast = [];
            console.log('calling loadCFM: ', id);
            loadCastForMovie(id).then(function (date) {
                cast = date;
                console.log('ALL CAST: ', cast);
                let castList = '<ul>';
                for (let actor of cast) {
                    castList += `<li>${actor.firstname}, ${actor.lastname}</li>`;
                }
                castList += "</ul>";
                
                $(selector).html(castList);
            })

        });
    });



}