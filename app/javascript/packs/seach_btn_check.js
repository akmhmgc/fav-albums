const button = document.querySelector("#search_btn");

const search_form = document.querySelector("#search_form");

var search_check = function () {
    const form = search_form.value.replace(/^\s+/, '');
    if (form.length == 0) {
        button.disabled = true;
        button.classList.remove('bg-red-400');
        button.classList.add('bg-gray-200');
    } else {
        button.disabled = false;
        button.classList.add('bg-red-400');
        button.classList.remove('bg-gray-200');
    }
};

search_form.addEventListener('input',search_check);
