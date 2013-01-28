xquery version "3.0";

declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace util="http://exist-db.org/xquery/util";

let $id := request:get-parameter("id", util:uuid())
let $data := request:get-parameter("data", ())
let $isLoggedIn := xdb:login("xmldb:exist:///db/apps/activeletter", "admin", "user12345")
return 
    (:if ($data != ())
    then:)
        let $out := xdb:store("xmldb:exist:///db/apps/activeletter/data", concat($id, ".xml"), $data)
        let $url := concat("http://cg2.cs.ox.ac.uk:8080/exist/apps/activeletter/create?id=", replace(util:document-name($out), ".xml", ""))
        return
            $url
    (:else
        ("Failed to save data", $data):)