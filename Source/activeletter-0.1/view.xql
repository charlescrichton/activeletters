xquery version "3.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xdb="http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=html5 media-type=text/html";

let $id := request:get-parameter("id", ())
return
<html>
    <head>
        <title class="config:app-title">Active Letter</title>
        <link rel="stylesheet" type="text/less" href="../css/style.less"></link>
        <script type="text/javascript" src="../js/jquery.min.js"></script>
        <script type="text/javascript" src="../js/knockout.js"></script>
        <script type="text/javascript" src="../js/knockout.mapping.js"></script>
        <script type="text/javascript" src="../js/less.min.js"></script>
        <script type="text/javascript" src="../js/ko.model.js"></script>
        <script>
        {
            if ($id)
            then concat("var id='", $id, "';")
            else ()
        }
        </script>
            
    </head>
    <body data-bind="with: data">
        <h1>Active Letter</h1>
        <div>
            <h2>Topic of Letter</h2>
            <div class="topic_of_letter" data-bind="text: topic_of_letter"></div>
        </div>
        <div data-bind="with: contact_details">
            <h2>Contact Details</h2>
            <ul>
                <!-- ko foreach: contact -->
                <li data-bind="id"></li>
                <!-- /ko -->
            </ul>
        </div>
        <div>
            <h2>Patient Details</h2>
            <table data-bind="with: patient_details">
                <tr>
                    <th>NHS Number</th>
                    <td data-bind="text: nhs_number"></td> 
                </tr>
                <tr>
                    <th>Hospital Number</th>
                    <td data-bind="text: local_hospital_number"></td>
                </tr>
                <tr>
                    <th>Surname</th>
                    <td data-bind="text: surname"></td>
                </tr>
                <tr>
                    <th>Forename</th>
                    <td data-bind="text: forename"></td>
                </tr>
                <tr>
                    <th>Address Line 1</th>
                    <td data-bind="text: address_line_1"></td>
                </tr>
                <tr>
                    <th>Address Line 2</th>
                    <td data-bind="text: address_line_2"></td>
                </tr>
                <tr>
                    <th>Address Line 3</th>
                    <td data-bind="text: address_line_3"></td>
                </tr>
                <tr>
                    <th>Post Code</th>
                    <td data-bind="text: postcode"></td>
                </tr>
                <tr>
                    <th>Preferred Email Address</th>
                    <td data-bind="text: preferred_email_address"></td>
                </tr>
                <tr>
                    <th>Date of Birth</th>
                    <td data-bind="text: date_of_birth"></td>
                </tr>
            </table>
        </div>
        <div>
            <h2>Letter</h2>
            <table data-bind="with: letter">
                <tr>
                    <th>Consultant Name</th>   
                    <td data-bind="text: consultant_name"></td>
                </tr>
                <tr>
                    <th>Diagnosis</th>
                    <td data-bind="text: diagnosis"></td>
                </tr>
                <tr>
                    <th>Narrative</th>
                    <td data-bind="text: narrative"></td>
                </tr>
            </table>
        </div>
        <div>
            <h3>Task List</h3>
            <table data-bind="with: task_list">
                <tbody data-bind="foreach: task">
                <tr>
                    <td>
                        <p class="label">Description</p>
                        <p data-bind="text: description"></p>
                        <p class="label">Help Link</p>
                        <p data-bind="text: help_link"></p>
                        <p class="label">Frequency</p>
                        <p data-bind="text: frequency"></p>
                        <p class="label">Next Due Date</p>
                        <p data-bind="text: next_due_date"></p>
                        <p class="label">Dates Action Taken</p>
                        <ul data-bind="with: dates_action_taken">
                            <!-- ko foreach: date -->
                            <li data-bind="text: $data"></li>
                            <!-- /ko -->
                        </ul>
                        <p class="label">Actions</p>
                        <table data-bind="with: actions">
                            <tr data-bind="visible: action.length > 0">
                                <th>Trigger</th>
                                <th>Status</th>
                                <th>Result</th>
                                <th>Notes</th>
                            </tr>
                            <tbody data-bind="foreach: action">
                            <tr>
                                <td data-bind="text: trigger"></td>
                                <td data-bind="text: status"></td>
                                <td data-bind="text: result"></td>
                                <td data-bind="text: notes"></td>
                            </tr>    
                            </tbody>
                        </table>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>