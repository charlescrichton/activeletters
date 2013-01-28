xquery version "3.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";

declare option exist:serialize "method=json media-type=text/javascript";

let $id := request:get-parameter("id", ())
return
    if ($id)
    then 
        let $url := concat("data/", $id, ".xml")
        return doc($url)
    else 
        doc("templates/template2.xml")