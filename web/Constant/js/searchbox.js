const dept_selected = document.querySelector(".dept-selected");
const dept_optionsContainer = document.querySelector(".dept-options-container");
const dept_searchBox = document.querySelector(".dept-search-box input");
const dept_optionsList = document.querySelectorAll(".dept-option");


var dept_flag=false;
var arriv_flag=false;

dept_selected.addEventListener("click", () => {
    dept_flag=true;
    dept_optionsContainer.classList.toggle("active");
    console.log("aaa");
    dept_searchBox.value = "";
    dept_filterList("");

    if (dept_optionsContainer.classList.contains("active")) {
        dept_searchBox.focus();
    }
});


dept_optionsList.forEach(o => {
    o.addEventListener("click", () => {
        if(dept_flag==true){
            dept_selected.innerHTML = o.querySelector("label").innerHTML;
            dept_optionsContainer.classList.remove("active");
            dept_flag=false;
        }
    });
});

dept_searchBox.addEventListener("keyup", function(e) {
    dept_filterList(e.target.value);
});

const dept_filterList = searchTerm => {
    searchTerm = searchTerm.toLowerCase();
    dept_optionsList.forEach(dept_option => {
        let label = dept_option.firstElementChild.nextElementSibling.innerText.toLowerCase();
        if (label.indexOf(searchTerm) != -1) {
            dept_option.style.display = "block";
        } else {
        dept_option.style.display = "none";
        }
    });
};

const arriv_selected = document.querySelector(".arriv-selected");
const arriv_optionsContainer = document.querySelector(".arriv-options-container");
const arriv_searchBox = document.querySelector(".arriv-search-box input");

const arriv_optionsList = document.querySelectorAll(".arriv-option");

arriv_selected.addEventListener("click", () => {
    sel_flag =true;
    arriv_optionsContainer.classList.toggle("active");
    arriv_searchBox.value = "";
    arriv_filterList("");
    if (arriv_optionsContainer.classList.contains("active")) {
        arriv_searchBox.focus();
    }
});

arriv_optionsList.forEach(o => {
    o.addEventListener("click", () => {
        if(sel_flag==true){
            arriv_selected.innerHTML = o.querySelector("label").innerHTML;
            arriv_optionsContainer.classList.remove("active");
            sel_flag=false;
        }
    });
});

arriv_searchBox.addEventListener("keyup", function(e) {
    arriv_filterList(e.target.value);
});

const arriv_filterList = searchTerm => {
    searchTerm = searchTerm.toLowerCase();
    arriv_optionsList.forEach(option => {
        let label = option.firstElementChild.nextElementSibling.innerText.toLowerCase();
        if (label.indexOf(searchTerm) != -1) {
            option.style.display = "block";
        } else {
        option.style.display = "none";
        }
    });
};
