function ShowSvg(svgdefinition){
    var d1 = document.getElementById('controlAddIn');
    d1.innerHTML = '';
    d1.insertAdjacentHTML('beforeend', svgdefinition);  
}



function svgDefToPng(svgdefinition, code){
    svgUrlToPng(getSvgUrl(svgdefinition), code);
}

function getSvgUrl(svg) {
    return URL.createObjectURL(new Blob([svg], {
      type: 'image/svg+xml'
    }));
  }

function svgUrlToPng(svgUrl, code) {
    const svgImage = document.createElement('img');
    document.body.appendChild(svgImage);
    svgImage.onload = () => {
      const canvas = document.createElement('canvas');
      canvas.width = svgImage.clientWidth;
      canvas.height = svgImage.clientHeight;
      const canvasCtx = canvas.getContext('2d');
      canvasCtx.drawImage(svgImage, 0, 0);
      const imgData = canvas.toDataURL('image/png');
      //const imgData = canvas.toDataURL('image/jpeg', 1.0);
      Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('svgUrlToPngCallback', [imgData, code]);
      document.body.removeChild(imgPreview);
    };
    svgImage.src = svgUrl;
  }

