function loadHomePage() {

    let lang = localStorage.getItem('SITE_LANGUAGE') ? localStorage.getItem('SITE_LANGUAGE') : 'en';
    //let hpm = loadHomePageMovies(lang);
    let hpm = [];
    loadHomePageMovies(lang).then(function (date) {

        hpm = date;


        let htmlContent = `
        <div class="gallery">
            <div class="buttons"><a class="prev" href="#">&lt; Previous</a> | <a class="next" href="#">Next &gt;</a></div>
          <h1>Latest movies </h1>
          <div class="photos">`

        let index = 2;
        let active = true;
        for (let hm of hpm) {
            htmlContent += `<div  style='background: url(${hm.thumbnailUrl}); background-repeat: no-repeat' class="block block-${index++} ${active ? 'active' : ''}">`;
            htmlContent += `
           `;
            htmlContent += '</div>';
            active = false;
        }
        htmlContent += `</div>         
        </div>`;

        $('#page-content').html(htmlContent);

        var nextBtn = document.querySelector(".gallery .buttons .next");
        var prevBtn = document.querySelector(".gallery .buttons .prev");
        var slide = document.querySelectorAll(".gallery .photos .block");
        var i = 0;

        prevBtn.onclick = function () {
            slide[i].classList.remove("active");
            i--;

            if (i < 0) {
                i = slide.length - 1;
            }
            slide[i].classList.add("active");
        };

        nextBtn.onclick = function () {
            slide[i].classList.remove("active");
            i++;

            if (i >= slide.length) {
                i = 0;
            }

            slide[i].classList.add("active");
        };

    });

}

function checkLogin(){
    var promise = new Promise(function(resolve, reject){
        $.ajax({
            url : 'rest_controller.php?is_logged_in=1',
            success : function(data){
                data = JSON.parse(data);
                resolve(data);
            }
        });
        
    });
    return promise;
}



$(document).ready(function () {


    checkLogin().then(function (data){
        
          
        if(data.status == 'logged_in' && data['user_type'] == 'ADMIN'){
            console.log('logged in and admin')
        }else{
            console.log('not logged in');
            $('#admin-section-link').hide();
        }
    });

    $('.sel-language').click(function (event) {
        event.preventDefault();
        let language = $(this).attr('data-lang');
        localStorage.setItem('SITE_LANGUAGE', language);
        console.log('switch language to: ' + language);


        // <a href="#" data-page="home" class="sel-page" id="home-link">Home</a>
        // <a href="#" data-page="cinema" class="sel-page" id="cinema-link">Cinema</a>
        // <div class="dropdown">
        //     <button class="dropbtn" id="admin-section-link">Admin Section
        //         <i class="fa fa-caret-down"></i>
        //     </button>
        //     <div class="dropdown-content">
        //         <a href="#" >Heatmap</a>
        //         <a href="#" id="reports-link">Reports</a>
        //         <a href="#" data-page="admin/users" class="sel-page" id="user-stats-link">User statistics</a>
        //     </div>
        if(language == 'ro'){
            $('#home-link').html('Prima Pagina');
            $('#cinema-link').html('Filme');
            $('#admin-section-link').html('Sectiune Administrare');
            $('#reports-link').html('Rapoarte');

        }else{
            $('#home-link').html('Home');
            $('#cinema-link').html('Cinema');
            $('#admin-section-link').html('Admin Section');
            $('#reports-link').html('Reports');
            
        }

        var path = localStorage.getItem('CURRENT_PAGE');
        console.log('path = ', path, ' language = ', language);

        if (path == 'home') {
            loadHomePage(language);
        } else if (path == 'cinema') {
            refreshPage(language);
        } else if(path == 'admin/users'){
            console.log('showing admin page');
        }else{
            console.log('NO PAGE SELECTED');
        }
    });
});