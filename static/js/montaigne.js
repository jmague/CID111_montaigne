var editionColors = {};
editionColors["e1582"] = "#ccffcc";
editionColors["e1588"] = "#ccccff";
editionColors["e1598"] = "#ffcccc";

function hide(edition){
  var variantes = document.getElementsByClassName('wit_'+edition);
  for (var i = 0; i < variantes.length; i ++) {
      variantes[i].style.display = 'none';
  }
}
function show(edition){
  var variantes = document.getElementsByClassName('wit_'+edition);
  for (var i = 0; i < variantes.length; i ++) {
      if (variantes[i].nodeName=='SPAN'){
        variantes[i].style.display = 'inline';
      }
      else{
        variantes[i].style.display = 'block';
      }
  }
}

function addBrackets(edition){
  var variantes = document.getElementsByClassName('wit_'+edition);
  for (var i = 0; i < variantes.length; i ++) {
    if (variantes[i].textContent.length==0){
        variantes[i].setAttribute('data-before','[');
        variantes[i].setAttribute('data-after',']');
      }
  }
}
function removeBrackets(edition){
  var variantes = document.getElementsByClassName('wit_'+edition);
  for (var i = 0; i < variantes.length; i ++) {
      variantes[i].setAttribute('data-before','');
      variantes[i].setAttribute('data-after','');
  }
}


function setColors(edition, color){
  var variantes = document.getElementsByClassName('wit_'+edition);
  for (var i = 0; i < variantes.length; i ++) {
      variantes[i].style.background = color;
  }
}

function eventFire(el, etype){
  if (el.fireEvent) {
    el.fireEvent('on' + etype);
  } else {
    var evObj = document.createEvent('Events');
    evObj.initEvent(etype, true, false);
    el.dispatchEvent(evObj);
  }
}

function addColors(){
  if(this.checked){
    setColors('e1582', editionColors['e1582']);
    addBrackets('e1582');
    document.getElementById('e1582selector').style.background = editionColors['e1582'];
    setColors('e1588', editionColors['e1588']);
    addBrackets('e1588');
    document.getElementById('e1588selector').style.background = editionColors['e1588'];
    setColors('e1598', editionColors['e1598']);
    addBrackets('e1598');
    document.getElementById('e1598selector').style.background = editionColors['e1598'];
    
  }
  else{
    setColors('e1582', '#ffffff');
    removeBrackets('e1582');
    document.getElementById('e1582selector').style.background = '#ffffff';
    setColors('e1588', '#ffffff');
    removeBrackets('e1588');
    document.getElementById('e1588selector').style.background = '#ffffff';
    setColors('e1598', '#ffffff');
    removeBrackets('e1598');
    document.getElementById('e1598selector').style.background = '#ffffff';
  }
}


function initMontaigne(){
  var useColor  = document.selectEdition.useColor;
  useColor.onclick = addColors
  

  
  var rad = document.selectEdition.edition;
  for(var i = 0; i < rad.length; i++) {
      rad[i].onclick = function() {
        switch (this.value) {
          case 'e1582':
            show('e1582');
            hide('e1588');
            hide('e1598');
            break;
          case 'e1588':
            hide('e1582');
            show('e1588');
            hide('e1598');
            break;
          case 'e1598':
            hide('e1582');
            hide('e1588');
            show('e1598');
            break;
          case 'all':
            show('e1582');
            show('e1588');
            show('e1598');
            document.selectEdition.useColor.checked = true;
            addColors()

            break;
          default:
            break;
        };        
      };
  }
}
