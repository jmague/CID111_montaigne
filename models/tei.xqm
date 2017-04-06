xquery version "3.0" ;
module namespace montaigne.models.tei = 'montaigne.models.tei' ;

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



(: Put here all import modules declarations as needed :)
import module namespace synopsx.models.synopsx = 'synopsx.models.synopsx' at '../../../models/synopsx.xqm' ;

declare namespace tei = 'http://www.tei-c.org/ns/1.0' ;

(: Use a default namespace :)
declare default function namespace 'montaigne.models.tei' ;

(:~
 : this function returns a sequence of map for meta and content
 : !! the result structure has changed to allow sorting early in mapping
 :
 : @rmq for testing with new htmlWrapping
 :)
declare function getDivById($queryParams as map(*)) as map(*) {

  let $meta := map{
    }
  let $content := map{
    'tei' :  synopsx.models.synopsx:getDb($queryParams)//tei:TEI[@xml:id='montaigne']//tei:div[@xml:id=$queryParams('id')]
  }

  return  fn:trace(map{
    'meta'    : $meta,
    'content' : $content
    })
};

(:~
 : this function returns a sequence of map for meta and content
 : !! the result structure has changed to allow sorting early in mapping
 :
 : @rmq for testing with new htmlWrapping
 :)
 (:~
  : this function returns a sequence of map for meta and content
  : !! the result structure has changed to allow sorting early in mapping
  :
  : @rmq for testing with new htmlWrapping
  :)
 declare function getTextById($queryParams as map(*)) as map(*) {
   let $text := synopsx.models.synopsx:getDb($queryParams)//tei:TEI[@xml:id=$queryParams('id')]
   let $meta := map{
     'title' : $text/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/text(),
     'author': $text/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author//text()
     }
   let $content :=  map{
     'tei' : $text/tei:text
   }
   return  map{
     'meta'    : $meta,
     'content' : $content
     }
 };
(:~
 : this function returns a sequence of map for meta and content
 : !! the result structure has changed to allow sorting early in mapping
 :
 : @rmq for testing with new htmlWrapping
 :)
declare function getEditorsList($queryParams as map(*)) as map(*) {
  let $editors := synopsx.models.synopsx:getDb($queryParams)//tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt[tei:resp="Editeur"]/tei:persName
  let $meta := map{
    'title' : 'Editeurs'
    }
    let $content := for $editor in $editors
     order by $editor/tei:surname , $editor/tei:forename
       return
       map {
            'surname':$editor/tei:surname,
            'forename':$editor/tei:forename,
            'essai_id' : $editor/ancestor::tei:TEI/@xml:id,
            'essai_title' : $editor/ancestor::tei:titleStmt/tei:title/text()
           }
  return  map{
    'meta'    : $meta,
    'content' : $content
    }
};



(:~
 : this function returns a sequence of map for meta and content
 : !! the result structure has changed to allow sorting early in mapping
 :
 : @rmq for testing with new htmlWrapping
 :)
declare function getPersonsList($queryParams as map(*)) as map(*) {
  let $meta := map{
    'title' : 'Les Personnes'
    }
  let $content := for $person in fn:trace(synopsx.models.synopsx:getDb($queryParams)//tei:teiHeader//tei:listPerson/tei:person)
   order by $person/tei:persName[1]/text()
     return
     map {
          'name':$person/tei:persName[1]/text(),
          'id' : $person/@xml:id
         }
  return  map{
    'meta'    : $meta,
    'content' : $content
    }
};



(:~
 : this function returns a sequence of map for meta and content
 : !! the result structure has changed to allow sorting early in mapping
 :
 : @rmq for testing with new htmlWrapping
 :)
declare function getPersonOccurrences($queryParams as map(*)) as map(*) {
  let $meta := map{
    'title' : 'Les Essais'
    }
let $here:=fn:trace("there")

  let $content := for $text in fn:trace(synopsx.models.synopsx:getDb($queryParams)//tei:body//tei:persName[@*:corresp="#Aeneas"])
      return
     map {
          'title':$text//tei:titleStmt/title/text(),
          'id' : $text/@xml:id
         }
  return  map{
    'meta'    : $meta,
    'content' : $content
    }
};


(:~
 : this function returns a sequence of map for meta and content
 : !! the result structure has changed to allow sorting early in mapping
 :
 : @rmq for testing with new htmlWrapping
 :)
declare function getEssaisList($queryParams as map(*)) as map(*) {
  let $meta := map{
    'title' : 'Les Essais'
    }
  let $content := for $essai in fn:trace(synopsx.models.synopsx:getDb($queryParams)/tei:TEI[fn:not(//tei:titleStmt/tei:author)])
   order by $essai//tei:titleStmt/tei:title
     return
     map {
          'id': fn:data($essai/@xml:id),
          'title':$essai//tei:titleStmt/tei:title/text()
         }
  return  map{
    'meta'    : $meta,
    'content' : $content
    }
};


(:~
 : this function returns a sequence of map for meta and content
 : !! the result structure has changed to allow sorting early in mapping
 :
 : @rmq for testing with new htmlWrapping
 :)
declare function getReportsList($queryParams as map(*)) as map(*) {
  let $meta := map{
    'title' : 'Rapports des étudiants'
    }
  let $content := for $essai in synopsx.models.synopsx:getDb($queryParams)/tei:TEI[//tei:titleStmt/tei:author]
   order by $essai//tei:titleStmt/tei:author
     return
     map {
          'id': fn:data($essai/@xml:id),
          'title':$essai//tei:titleStmt/tei:title/text(),
          'author': $essai//tei:titleStmt/tei:author/tei:persName/text()
         }
  return  map{
    'meta'    : $meta,
    'content' : $content
    }
};
