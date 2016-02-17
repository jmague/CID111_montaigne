xquery version "3.0" ;
module namespace montaigne.webapp = 'montaigne.webapp' ;

(:~
 : This module is the RESTXQ for SynopsX's montaigne
 :
 : @version 2.0 (Constantia edition)
 : @since 2015-02-05 
 : @author synopsx team
 :
 : This file is part of SynopsX.
 : created by AHN team (http://ahn.ens-lyon.fr)
 :
 : SynopsX is free software: you can redistribute it and/or modify
 : it under the terms of the GNU General Public License as published by
 : the Free Software Foundation, either version 3 of the License, or
 : (at your option) any later version.
 :
 : SynopsX is distributed in the hope that it will be useful,
 : but WITHOUT ANY WARRANTY; without even the implied warranty of
 : MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 : See the GNU General Public License for more details.
 : You should have received a copy of the GNU General Public License along 
 : with SynopsX. If not, see http://www.gnu.org/licenses/
 :
 :)

(: Import synopsx's globals variables and libraries :)
import module namespace G = "synopsx.globals" at '../../../globals.xqm' ;
import module namespace synopsx.models.synopsx = 'synopsx.models.synopsx' at '../../../models/synopsx.xqm' ;

(: Put here all import modules declarations as needed :)
import module namespace synopsx.models.tei = 'synopsx.models.tei' at '../../../models/tei.xqm' ;
import module namespace montaigne.models.tei = 'montaigne.models.tei' at '../models/tei.xqm' ;

(: Put here all import declarations for mapping according to models :)
import module namespace synopsx.mappings.htmlWrapping = 'synopsx.mappings.htmlWrapping' at '../../../mappings/htmlWrapping.xqm' ;

declare namespace tei = 'http://www.tei-c.org/ns/1.0' ;

(: Use a default namespace :)
declare default function namespace 'montaigne.webapp' ;


declare variable $montaigne.webapp:project := 'montaigne' ;
declare variable $montaigne.webapp:db := synopsx.models.synopsx:getProjectDB($montaigne.webapp:project) ;



(:~
 : this resource function redirect to /home
 :
 :)
declare 
  %restxq:path("/montaigne")
function index() {
  <rest:response>
    <http:response status="303" message="See Other">
      <http:header name="location" value="/montaigne/home"/>
    </http:response>
  </rest:response>
};

(:~
 : resource function is the html representation of the corpus resource
 :
 : @return an html representation of the corpus resource with a bibliographical list
 : the HTML serialization also shows a bibliographical list
 :)
declare 
  %restxq:path('/montaigne/{$page}')
  %rest:produces('text/html')
  %output:method("html")
  %output:html-version("5.0")
function page($page) {
  let $queryParams := map {
    'project' : $montaigne.webapp:project,
    'dbName' :  $montaigne.webapp:db,
    'model' : 'tei' ,
    'function' : 'getDivById',
    'id' : $page
    }
  let $outputParams := map {
    'lang' : 'fr',
    'layout' : 'home.xhtml',
    'pattern' : 'inc_defaultItem.xhtml' ,
    'xsl' : 'montaigne.xsl'
    }  
 return synopsx.models.synopsx:htmlDisplay($queryParams, $outputParams)
};


(:~
 : this resource function is the html representation of the corpus resource
 :
 : @return an html representation of the corpus resource with a bibliographical list
 : the HTML serialization also shows a bibliographical list
 :)
declare
  %restxq:path('/montaigne/editeurs')
  %rest:produces('text/html')
  %output:method("html")
  %output:html-version("5.0")
function editors() {
  let $queryParams := map {
    'project' : $montaigne.webapp:project,
    'model' : 'tei' ,
    'function' : 'getEditorsList'
    }
  let $outputParams := map {
    'lang' : 'fr',
    'layout' : 'home.xhtml',
    'pattern' : 'inc_editorItem.xhtml'   
    }
 return synopsx.models.synopsx:htmlDisplay($queryParams, $outputParams)
};


(:~
 : this resource function is the html representation of the corpus resource
 :
 : @return an html representation of the corpus resource with a bibliographical list
 : the HTML serialization also shows a bibliographical list
 :)
declare 
  %restxq:path('/montaigne/essais')
  %rest:produces('text/html')
  %output:method("html")
  %output:html-version("5.0")
function essais() {  
    let $queryParams := map {
    'project' : $montaigne.webapp:project,
    'model' : 'tei' ,
    'function' : 'getEssaisList'
    }
   let $outputParams := map {
    'lang' : 'fr',
    'layout' : 'home.xhtml',
    'pattern' : 'inc_textTitleItem.xhtml'
    }
 return synopsx.models.synopsx:htmlDisplay($queryParams, $outputParams)
};


(:~
 : this resource function is the html representation of the corpus resource
 :
 : @return an html representation of the corpus resource with a bibliographical list
 : the HTML serialization also shows a bibliographical list
 :)
declare 
  %restxq:path('/montaigne/essai/{$id}')
  %rest:produces('text/html')
  %output:method("html")
  %output:html-version("5.0")
function essai($id) {  
    let $queryParams := map {
    'project' : $montaigne.webapp:project,
    'model' : 'tei' ,
    'function' : 'getTextById',
    'id' : $id
    }
   let $outputParams := map {
    'lang' : 'fr',
    'layout' : 'essai.xhtml',
    'pattern' : 'inc_defaultItem.xhtml' ,
    'xsl' : 'montaigne.xsl'

    }
 return synopsx.models.synopsx:htmlDisplay($queryParams, $outputParams)
};



(:~
 : this resource function is the html representation of the corpus resource
 :
 : @return an html representation of the corpus resource with a bibliographical list
 : the HTML serialization also shows a bibliographical list
 :)
declare 
  %restxq:path('/montaigne/exemple')
  %rest:produces('text/html')
  %output:method("html")
  %output:html-version("5.0")
function exemple() {  
  let $editeurs := db:open('montaigne')/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt[tei:resp="Editeur"]/tei:persName
  return
    <html>
      <head>
      </head>
      <body>
        <ul>
        {
        for $editeur in $editeurs
        return <li>{$editeur/tei:surname/text()}</li>
        }
        </ul>
      </body>
    </html>
};
