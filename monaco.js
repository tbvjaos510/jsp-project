require.config({
    paths: {
        'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.13.1/min/vs'
    }
});
var editor;
// Before loading vs/editor/editor.main, define a global MonacoEnvironment that overwrites
// the default worker url location (used when creating WebWorkers). The problem here is that
// HTML5 does not allow cross-domain web workers, so we need to proxy the instantiation of
// a web worker through a same-domain script
window.MonacoEnvironment = {
    getWorkerUrl: function (workerId, label) {
        return `data:text/javascript;charset=utf-8,${encodeURIComponent(`
self.MonacoEnvironment = {
  baseUrl: 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.13.1/min/vs'
};
importScripts('https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.13.1/min/vs/base/worker/workerMain.js');`
)}`;
    }
};
// function changePreview(){
    
//     var xhttp = new XMLHttpRequest();
//     xhttp.open('POST', 'https://api.github.com/markdown/raw', true);
//     xhttp.setRequestHeader("Content-Type", "text/plain");
//     xhttp.onreadystatechange = function (evt){
//         if (xhttp.readyState == 4 && xhttp.status == 200){
//             console.log(xhttp.responseText);
//             document.getElementById('preview-frame').srcdoc = xhttp.responseText;
//         }
//     };
    
//     xhttp.send(editor.getValue());
// }
function changePreview(){
    var value = editor.getValue();
    var text = value,
    converter = new showdown.Converter(),
    html = converter.makeHtml(text);
    console.log(html);
    document.getElementById('preview-frame').srcdoc = html;
}
require(["vs/editor/editor.main"], function () {
    
    editor = monaco.editor.create(document.getElementById("editor"), {
        value: `# Header 1 #
## Header 2 ##
### Header 3 ###             (Hashes on right are optional)
## Markdown plus h2 with a custom ID ##   {#id-goes-here}
[Link back to H2](#id-goes-here)`,
        language: "markdown"
    });
    editor.onDidChangeModelContent(function (e) {
        changePreview(editor);
    });
    window.onresize = function (evt){
        editor.layout();
    };
});