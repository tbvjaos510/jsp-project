Element.prototype.remove = function() {
    this.parentElement.removeChild(this);
}
NodeList.prototype.remove = HTMLCollection.prototype.remove = function() {
    for(var i = this.length - 1; i >= 0; i--) {
        if(this[i] && this[i].parentElement) {
            this[i].parentElement.removeChild(this[i]);
        }
    }
}

/**
 * 
 * @param {Element} element 
 */
function removeMemo(element, id){
    var params = "mode=remove&memoid=" + id;
    var xhttp = new XMLHttpRequest();
    xhttp.open('POST', '/sanghie/memo.jsp?' + params, true);
    xhttp.onreadystatechange = function (evt) {
        if (xhttp.readyState == 4 && xhttp.status == 200) {
            console.log(xhttp.responseText);
            
        }
    }
    xhttp.send();
    element.parentElement.remove();
}
