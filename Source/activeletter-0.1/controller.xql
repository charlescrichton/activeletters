xquery version "3.0";

declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;

if ($exist:path eq "/" or contains($exist:path, "/rest/")) then
    (: forward root path to index.xql :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="create.xql"/>
    </dispatch>
else if (contains($exist:path, "/view/")) then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="../view.xql">
            <add-parameter name="id" value="{$exist:resource}"/>
        </forward>
    </dispatch>
else if ($exist:path eq "/create") then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="create.xql"/>
    </dispatch>
else if ($exist:path eq "/submit") then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="submit.xql"/>
    </dispatch>
else
    (: everything else is passed through :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="yes"/>
    </dispatch>
