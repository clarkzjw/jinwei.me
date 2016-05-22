var sleep = function(ms, callback) {
        setTimeout(function() {
            callback()
        }, ms)
    },
    favthings = ["raspberrypi", "Linux", "Let's Encrypt", "Ingress", "Computer Vision", 
"Machine Learning"],
    removeClass = function(el, className) {
        el.classList ? el.classList.remove(className) : el.className = 
el.className.replace(new RegExp("(^|\\b)" + className.split(" ").join("|") + "(\\b|$)", 
"gi"), " ")
    },
    addClass = function(el, className) {
        el.classList ? el.classList.add(className) : el.className += " " + className
    },
    i = 0,
    nextThing = function(thing) {
        i < favthings.length - 1 ? i++ : i = 0, removeClass(thing, "slideInDown"), 
addClass(thing, "slideOutUp"), sleep(700, function() {
            thing.innerHTML = favthings[i], removeClass(thing, "slideOutUp"), 
addClass(thing, "slideInDown")
        })
    };
document.addEventListener("DOMContentLoaded", function() {
    var thing = document.querySelectorAll(".favthing")[0];
    setTimeout(function() {
        nextThing(thing)
    }, 1e3), setInterval(function() {
        nextThing(thing)
    }, 4e3)
});

