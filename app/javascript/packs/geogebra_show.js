function remove_first_occurrence(str, searchstr) {
    var index = str.indexOf(searchstr);
    if (index === -1) {
        return str;
    }
    return str.slice(0, index) + str.slice(index + searchstr.length);
}
var element = document.getElementById("base64_id")
var myBase = element.getAttribute("base64");
var parameters = {
                "appName": "classic",
                "width":800,
                "height":600,
                "showToolBar":false,
                "borderColor":null,
                "showMenuBar":false,
                "customToolbar":"0 || 1 || 15 || 7 ",
                "allowStyleBar":true,
                "showAlgebraInput":false,
                "enableLabelDrags":false,
                "enableShiftDragZoom":true,
                "capturingThreshold":null,
                "showToolBarHelp":false,
                "errorDialogsActive":true,
                "showTutorialLink":true,
                "showLogging":true,
                "useBrowserForJS":true,
                "perspective":2,
                "grid":true,
                "ggbBase64": myBase            
                };
var applet = new GGBApplet(parameters, '5.0');
//  when used with Math Apps Bundle, uncomment this:
//  applet.setHTML5Codebase('GeoGebra/HTML5/5.0/web/');
window.onload = function() { applet.inject('applet_container'); }

function saveGgbFile(){ ggbApplet.getBase64(function(b){document.getElementById("Base64").value = b}); }
function loadGgbFile(){ ggbApplet.setBase64(document.getElementById("Base64").value); }
