//globals
  const options = {
    subtree: true,
    attributes: true
  }
  
  const observer = new MutationObserver(callback);

  function callback(mutationList, observer) {
    mutationList.forEach(function(mutation) {
      if (mutation.type === 'attributes' && mutation.attributeName === 'class') {
        console.log(mutation, observer);
      }
    })
  }
  //debugger;
    //observer.observe(addinnode, options);  //looking for changes 

 

  function InitializeControl(controlId) {
}


function FindAndSetTileGroup(elementid, caption, setfindcontrol) {
    nodes = window.parent.document.querySelectorAll(elementid); //find all controls by page name
   
    //find the control addin and set size - class="control-addin-container"
    parentnodes = nodes[nodes.length - 1].offsetParent;
    parentnodes = parentnodes.querySelectorAll('[class="control-addin-container"]');
    addinnode = parentnodes[0].childNodes[0];

    //set caption 
    nodes[nodes.length - 1].text = caption;
    nodes[nodes.length - 1].textContent = caption;
    nodes[nodes.length - 1].setAttribute('id',setfindcontrol); //so we can find the tilegroup later
    
    addinnode.setAttribute('style', 'height: 1px; max-height: 1px; width: 1px; max-width: 1px');
}

function SetGroupCaption1(elementid,Caption1, Caption2){
    nodes = window.parent.document.querySelectorAll(elementid); //find all controls by page name
    parentnodes = nodes[nodes.length - 1].offsetParent;
    
    title1 = parentnodes.querySelectorAll('[title="group01"]');
    title2 = parentnodes.querySelectorAll('[title="group02"]');

    if (title1.length > 0){
        title1[title1.length - 1].textContent = Caption1;
    }

    if (title2.length > 0){
        title2[title2.length - 1].textContent = Caption2;
    }
}

function SetGroupCaption2(elementid,Caption1, Caption2, Caption3, Caption4){
    nodes = window.parent.document.querySelectorAll(elementid); //find all controls by page name
    parentnodes = nodes[nodes.length - 1].offsetParent;
    
    title1 = parentnodes.querySelectorAll('[title="group11"]');
    title2 = parentnodes.querySelectorAll('[title="group12"]');
    title3 = parentnodes.querySelectorAll('[title="group13"]');
    title4 = parentnodes.querySelectorAll('[title="group14"]');

    if (title1.length > 0){
        title1[title1.length - 1].textContent = Caption1;
    }

    if (title2.length > 0){
        title2[title2.length - 1].textContent = Caption2;
    }

    if (title3.length > 0){
        title3[title3.length - 1].textContent = Caption3;
    }

    if (title4.length > 0){
        title4[title4.length - 1].textContent = Caption4;
    }
}


function EditTile(elementid,groupid,tileid,removenumber,peektext,peektextstyle,tilebackground, tilefontcolor, iconsvg){
    
    nodes = window.parent.document.querySelectorAll(elementid); //find all controls by page name   
    parentnodes = nodes[nodes.length - 1].offsetParent;
    
    tilegroups = parentnodes.querySelectorAll('[class="flex"], [class="flex part-field-hidden-before-form-open"]');
    if (tilegroups.length > 0){
        currtilegroup = tilegroups[groupid - 1];
        tiles = currtilegroup.querySelectorAll('ul li');
        if (tiles.length > 0) {
            tile = tiles[tileid - 1];
            //change tile colour
            tilestyle = tile.querySelector('div div div a'); //path to the tile <a>
            if (tilebackground != '' && tilefontcolor != ''){
                tilestyle.setAttribute('style', 'background:'+tilebackground+' !important', 'color:'+tilefontcolor+' !important');
            }
            if (tilebackground != ''&& tilefontcolor == ''){
                tilestyle.setAttribute('style', 'background:'+tilebackground+' !important');
            }
            if (tilebackground == '' && tilefontcolor != ''){
                tilestyle.setAttribute('style',  'color:'+tilefontcolor+' !important');
            }

            //remove the counter
            if (removenumber) {
                //debugger;
                number = tile.querySelectorAll("span[class^='number-']");  //starts with number-
                iconcontainer = number[0].parentNode;
                number[0].remove(); //textContent = '';
               
                if (iconsvg != '') {
                    iconcontainer.setAttribute('class','');
                    iconcontainer.setAttribute('style','text-align:right');
                    iconcontainer.innerHTML = ' ' + iconsvg;
                } 
            } else {
                if (iconsvg != '') {
                    number = tile.querySelectorAll("span[class^='number-largest']");  //starts with number-largest -> onl if we have the large number!
                    if (number.length > 0){
                        // iconcontainer = number[0].parentNode;
                        // iconcontainer.setAttribute('class','');
                        // iconcontainer.setAttribute('style','text-align:right');
                        
                        //iconcontainer.innerHTML = ' ' + iconsvg;
                    }
                }
            }

            if (peektext != ''){
                peek = tile.querySelectorAll("div[class^='peek-']");  //starts with peek-
                peek = tile.querySelector("span span");
                peek.style = peektextstyle;
                peek.textContent = peektext;
            }
        }
    }
}

function FindAndRemoveTileGroup(elementid) {
    nodes = window.parent.document.querySelectorAll(elementid); //find all controls by page name
    parentnodes = nodes[nodes.length - 1].offsetParent;
    parentnodes.remove();
}

function FindAndRemoveTileGroupNoMenuButton(elementid) {
    nodes = window.parent.document.querySelectorAll(elementid); //find all controls by page name
    parentnodes = nodes[nodes.length - 1].parentNode;
    parentnodesx = parentnodes.parentNode;
    parentnodes = parentnodesx.parentNode;
    parentnodesx = parentnodes.parentNode;  //this should be the final node!?
    parentnodesx.remove();
}

