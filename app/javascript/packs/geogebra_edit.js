//Variables
var params = {"appName": "classic",
                "width":800,
                "height":600,
                "showToolBar":true,
                "borderColor":null,
                "showMenuBar":true,
                "customToolbar":"0 || 1 || 15 || 7 || 38 || 36 || 17",
                "enableLabelDrags":true,
                "allowStyleBar":true,
                "showAlgebraInput":true,
                "enableShiftDragZoom":true,
                "capturingThreshold":null,
                "showToolBarHelp":false,
                "errorDialogsActive":true,
                "showTutorialLink":true,
                "showLogging":true,
                "useBrowserForJS":true,
                "enableShiftDragZoom": false,
                "perspective":2,
                "grid":true};
var myNodes = document.getElementById("myNodes"); // lista de puntos
var mySegments = document.getElementById("mySegments"); // lista de segmentos y vectores
var mySavedLink = document.getElementById("mySavedLink"); //saved link total state
var myForceVectors = document.getElementById("myForceValues"); // lista de vectores
var myMomentumValues = document.getElementById("myMomentumValues"); // lista de nodos que son momentos
//End Variables
params.appletOnLoad = function(api) {
    api.setGridVisible(true);
    api.setPointCapture(1,2)
    var strLength = 150;    
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

    function undoListener(objName) {
        printConstructionState();
    }

    function printConstructionState() {
        var strName;
        var strType;
        var objNumber = api.getObjectNumber();
        var subl = []; //lista de puntos
        var i;
        var myCurrentlink = ''; //resultado de json
        var lMomentumPoints = [];        
        var lconx = []; //lista conexiones segmentos + vectores
        var lvectores = []; //lista vectores
        for (i=0; i < objNumber; i++) {
            strName = api.getObjectName(i);                    
            strType = api.getObjectType(strName);
            
            if (strType === 'point') {
                if (api.getPointStyle(strName) === 3) {
                    lMomentumPoints.push({nombre: strName,  
                                        magnitude: 0 });
                }
                subl.push({nombre: strName, 
                        tipo: api.getPointStyle(strName), 
                        x: api.getXcoord(strName),
                        y: api.getYcoord(strName) });
            } else if (strType === 'segment' || strType === 'vector') {
                var smt_vct_values = {
                iType: api.getDefinitionString(strName),
                iLengthOrMagnitud: api.getValue(strName)
                };
                lconx.push(smt_vct_values);
                if (strType === 'vector') {
                    lvectores.push(smt_vct_values);
                }
            }
        }
        mySegments.value = JSON.stringify(lconx);
        mySavedLink.value = api.getBase64();              
        myNodes.value = JSON.stringify(subl); // lista de puntos
        myForceVectors.value = JSON.stringify(lvectores); // lista vectores
        myMomentumValues.value = JSON.stringify(lMomentumPoints);
    }
    // register add, remove, rename and update listeners
    api.registerAddListener(addListener);
    api.registerRemoveListener(removeListener);
    api.registerRenameListener(renameListener);
    api.registerClientListener(undoListener);
}
var applet = new GGBApplet(params, true);
window.addEventListener("load", function() { 
    applet.inject('ggb-element');
});