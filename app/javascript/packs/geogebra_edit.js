var params = {"appName": "classic",
                "width":800,
                "height":600,
                "showToolBar":true,
                "borderColor":null,
                "showMenuBar":true,
                "customToolbar":"0 || 1 || 15 || 7 ",
                "allowStyleBar":true,
                "showAlgebraInput":true,
                "enableLabelDrags":false,
                "enableShiftDragZoom":true,
                "capturingThreshold":null,
                "showToolBarHelp":false,
                "errorDialogsActive":true,
                "showTutorialLink":true,
                "showLogging":true,
                "useBrowserForJS":true,
                "perspective":2,
                "grid":true};
params.appletOnLoad = function(api) {
    api.setGridVisible(true);
    var strLength = 150;
    var myNodes = document.getElementById("myNodes"); // lista de puntos
    var mySegments = document.getElementById("mySegments"); // lista de segmentos y vectores
    var mySavedLink = document.getElementById("mySavedLink"); //saved link total state
    function addListener(objName) { 
        //textarea1.value = "add: " + objName + "\n" + textarea1.value.substring(0, strLength );	
        printConstructionState();
    }

    function removeListener(objName) {
        //textarea1.value = "remove: " + objName + "\n" + textarea1.value.substring(0, strLength );	
        printConstructionState();
    }

    function renameListener(oldObjName, newObjName) {
        //textarea1.value = "rename: " + objName + "\n" + textarea1.value.substring(0, strLength );	
        printConstructionState();
    }

    function printConstructionState() {
        var strName;
        var strType;
        var objNumber = api.getObjectNumber();
        var strState = "Number of objects: " + objNumber;
        var subl = []; //lista de puntos
        var node_value = {
            nombre: '',
            tipo: 0,
            x: 0,
            y: 0
        };          
        var lconx = []; //lista conexiones
        for (var i=0; i < objNumber; i++) {
            var subl2 = []; // lista por punto
            var lconx2 = [];// lista por conexion
            strName = api.getObjectName(i);                    
            strType = api.getObjectType(strName);                    
            if (strType === 'point') {
                node_value.nombre = strName;
                node_value.tipo = api.getPointStyle(strName);
                node_value.x = api.getXcoord(strName);
                node_value.y = api.getYcoord(strName);
                subl2.push(JSON.stringify(node_value));
                subl.push(subl2);
                strState += "\n" + strName+ ' x: ' + node_value.x + ' y: ' + node_value.y + ' style: '+ node_value.tipo;
            } else if (strType === 'segment' || strType === 'vector') {
                var smt_vct_values = {
                iType: api.getDefinitionString(strName),
                iLength: api.getValue(strName)
                };
                strState += "\n" + smt_vct_values.iType + ' L: ' + smt_vct_values.iLength;
                lconx2.push(JSON.stringify(smt_vct_values));
                lconx.push(lconx2);
            }
        }
        mySegments.value = lconx;
        mySavedLink.value = api.getBase64();              
        myNodes.value = subl; // lista de puntos
    }
    // register add, remove, rename and update listeners
    api.registerAddListener(addListener);
    api.registerRemoveListener(removeListener);
    api.registerRenameListener(renameListener);
}
var applet = new GGBApplet(params, true);
window.addEventListener("load", function() { 
    applet.inject('ggb-element');
});

function mchange(){
    var buttonFinished = document.getElementById("isFinished");
    var pid = document.getElementById("ihavename");
    pid.innerHTML = applet.getBase64();
}