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
        <link rel="stylesheet" type="text/css" href="css/smoothness/jquery-ui-1.10.0.custom.min.css"></link>
        <link rel="stylesheet" type="text/less" href="css/style.less"></link>
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/knockout.js"></script>
        <script type="text/javascript" src="js/knockout.mapping.js"></script>
        <script type="text/javascript" src="js/less.min.js"></script>
        <script type="text/javascript" src="js/jquery.qrcode.min.js"></script>
        <script type="text/javascript" src="js/qrcode.js"></script>
        
        <script>
        {
            if ($id)
            then concat("var id='", $id, "';")
            else ()
        }
        </script>
        <script type="text/javascript" src="js/ko.model.js"></script>
            
    </head>
    <body data-bind="with: data">
        <div style="width: 100%; padding-top: 100px; position: relative;">
            <h1 style="display: inline;">Active Letter</h1>
            <span id="qc" style="position: absolute; top: 20px; right: 0;"></span>
        </div>
        <div>
            <h2>Topic of Letter</h2>
            <input type="text" class="topic_of_letter" data-bind="value: topic_of_letter, valueUpdate: 'afterkeydown'" />
        </div>
        <div data-bind="with: contact_details">
            <h2>Contact Details</h2>
            <button type="button" data-bind="click: $root.addContact">Add Contact</button>
            <ul>
                <!-- ko foreach: contact -->
                <li>
                    <input type="text" data-bind="value: id, valueUpdate: 'afterkeydown'" /><span data-bind="click: $root.removeContact" style="color: #00f;margin-left: 10px; cursor: pointer;">delete</span>
                </li>
                <!-- /ko -->
            </ul>
        </div>
        <div>
            <h2>Patient Details</h2>
            <table data-bind="with: patient_details">
                <tr>
                    <th>Surname</th>
                    <td><input type="text" data-bind="value: surname, valueUpdate: 'afterkeydown'" /></td>
                </tr>
                <tr>
                    <th>Forename</th>
                    <td><input type="text" data-bind="value: forename, valueUpdate: 'afterkeydown'" /></td>
                </tr>
                <tr>
                    <th>Date of Birth</th>
                    <td><input type="text" data-bind="value: date_of_birth, valueUpdate: 'afterkeydown'" /></td>
                </tr>      
                <tr>
                    <th>NHS Number</th>
                    <td><input type="text" data-bind="value: nhs_number, valueUpdate: 'afterkeydown'" /></td> 
                </tr>
                <tr>
                    <th>Hospital Number</th>
                    <td><input type="text" data-bind="value: local_hospital_number, valueUpdate: 'afterkeydown'" /></td>
                </tr>
             
                <tr>
                    <th>Address Line 1</th>
                    <td><input type="text" data-bind="value: address_line_1, valueUpdate: 'afterkeydown'" /></td>
                </tr>
                <tr>
                    <th>Address Line 2</th>
                    <td><input type="text" data-bind="value: address_line_2, valueUpdate: 'afterkeydown'" /></td>
                </tr>
                <tr>
                    <th>Address Line 3</th>
                    <td><input type="text" data-bind="value: address_line_3, valueUpdate: 'afterkeydown'" /></td>
                </tr>
                <tr>
                    <th>Post Code</th>
                    <td><input type="text" data-bind="value: postcode, valueUpdate: 'afterkeydown'" /></td>
                </tr>
                <tr>
                    <th>Preferred Email Address</th>
                    <td><input type="text" data-bind="value: preferred_email_address, valueUpdate: 'afterkeydown'" /></td>
                </tr>
                <tr>
                    <th>Land line number</th>
                    <td><input type="text" data-bind="value: land_line_number, valueUpdate: 'afterkeydown'" /></td>
                </tr>
                 <tr>
                    <th>Mobile number</th>
                    <td><input type="text" data-bind="value: mobile_number, valueUpdate: 'afterkeydown'" /></td>
                </tr>
      
            </table>
        </div>
        <div>
            <h2>Letter</h2>
            <table data-bind="with: letter">
                <tr>
                    <th>Consultant Name</th>   
                    <td><input type="text" data-bind="value: consultant_name, valueUpdate: 'afterkeydown'" /></td>
                </tr>
                <tr>
                    <th>Diagnosis</th>
                    <td><input type="text" data-bind="value: diagnosis, valueUpdate: 'afterkeydown'" /></td>
                </tr>
                <tr>
                    <th>Narrative</th>
                    <td><textarea style="height: 200px;width:80%;" data-bind="value: narrative, valueUpdate: 'afterkeydown'"></textarea></td>
                </tr>
            </table>
        </div>
        <div>
            <h3>Task List</h3>
            <button type="button" data-bind="click: $root.addTask">Add Task</button>
            <table data-bind="with: task_list">
                <tbody data-bind="foreach: task">
                <tr>
                    <td>
                        <div data-bind="click: $root.removeTask" style="color: #00f;margin-left: 10px; cursor: pointer;width:99%;text-align: right;">delete</div>
                        <p class="label">Description</p>
                        <div>
                            <textarea style="height: 100px;width:80%;" data-bind="value: description, valueUpdate: 'afterkeydown'"></textarea>
                        </div>
                        <p class="label">Help Link</p>
                        <div>
                            <input type="text" data-bind="value: help_link, valueUpdate: 'afterkeydown'" />
                        </div>
                        <p class="label">Frequency</p>
                        <div>
                            <input type="text" data-bind="value: frequency, valueUpdate: 'afterkeydown'" />
                        </div>
                        <p class="label">Next Due Date</p>
                        <div>
                            <input type="text" data-bind="value: next_due_date, valueUpdate: 'afterkeydown'" />
                        </div>
                        <p class="label">Dates Action Taken</p>
                        <button type="button" data-bind="click: $root.addDate">Add Date</button>
                        <ul data-bind="with: dates_action_taken">
                            <!-- ko foreach: date -->
                            <li>
                                <input type="text" data-bind="value: $data, valueUpdate: 'afterkeydown'" />
                                <span data-bind="click: $root.removeDate.bind($data, $parent)" style="color: #00f;margin-left: 10px; cursor: pointer;">delete</span>
                            </li>
                            <!-- /ko -->
                        </ul>
                        <p class="label">Actions</p>
                        <button type="button" data-bind="click: $root.addAction">Add Action</button>
                        <table data-bind="with: actions">
                            <tr>
                                <th>Trigger</th>
                                <th>Status</th>
                                <th>Result</th>
                                <th>Notes</th>
                            </tr>
                            <!-- ko foreach: action -->
                            <tr>
                                <td><input type="text" data-bind="value: trigger, valueUpdate: 'afterkeydown'" /></td>
                                <td><input type="text" data-bind="value: status, valueUpdate: 'afterkeydown'" /></td>
                                <td><input type="text" data-bind="value: result, valueUpdate: 'afterkeydown'" /></td>
                                <td><input type="text" data-bind="value: notes, valueUpdate: 'afterkeydown'" /></td>
                                <td><span data-bind="click: $root.removeAction.bind($data, $parent)" style="color: #00f;margin-left: 10px; cursor: pointer;">delete</span></td>
                            </tr>    
                            <!-- /ko -->
                        </table>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
          <div>
            <h2>Guidance</h2>
            <table>
                <tr>
                    <th>Guidance</th>
                    <td><input type="textarea" data-bind="value: guidance, valueUpdate: 'afterkeydown'" /></td>
                </tr>
                
                  <tr>
                    <th>References</th>
                    <tr>
                        <p class="label">References</p>
                        <button type="button" data-bind="click: $root.addReference">Add Reference</button>
                        <table data-bind="with: references">
                            <tr>
                                <th>ID</th>
                                <th>Description</th>
                                <th>Reference URL</th>
                              
                            </tr>
                            <!-- ko foreach: reference -->
                            <tr>
                                <td><input type="text" data-bind="value: ref_id, valueUpdate: 'afterkeydown'" /></td>
                                <td><input type="text" data-bind="value: ref_description, valueUpdate: 'afterkeydown'" /></td>
                                <td><input type="text" data-bind="value: ref_reference, valueUpdate: 'afterkeydown'" /></td>
                              
                                <td><span data-bind="click: $root.removeReference.bind($data, $parent)" style="color: #00f;margin-left: 10px; cursor: pointer;">delete</span></td>
                            </tr>    
                            <!-- /ko -->
                        </table>
                    </tr>
                </tr>
            </table>
           
        </div>

          <div>
            <h2>Submission</h2>
             <button type="button" id="btnSubmit" style="clear: both; float: right;margin: 20px; padding: 15px;" data-bind="click: $root.submit">Submit</button>
            <div id="server-message" style="width:80%; background: #55cc55; color: #fff; padding: 10px;">
                <a href="" style="color: #fff; text-decoration: none;"></a>
            </div>

            </div>

        <div id="instance" style="display: none;">
            <active_letter xmlns="http://nhshack.org.uk/active_letter/1">
                <tags data-bind="text: tags" />
                <topic_of_letter data-bind="text: topic_of_letter"></topic_of_letter>
                <contact_details data-bind="with:contact_details">
                    <!-- ko foreach: contact -->
                    <contact>
                        <id data-bind="text: id" />
                    </contact>
                    <!-- /ko -->
                </contact_details>
                <patient_details data-bind="with:patient_details">
                    <nhs_number data-bind="text: nhs_number"></nhs_number>
                    <local_hospital_number data-bind="text: local_hospital_number"></local_hospital_number>
                    <surname data-bind="text: surname"></surname>
                    <forename data-bind="text: forename"></forename>
                    <address_line_1 data-bind="text: address_line_1"></address_line_1>
                    <address_line_2 data-bind="text: address_line_2"></address_line_2>
                    <address_line_3 data-bind="text: address_line_3"></address_line_3>
                    <postcode data-bind="text: postcode"></postcode>
                    <preferred_email_address data-bind="text: preferred_email_address"></preferred_email_address>
                    <date_of_birth data-bind="text: date_of_birth"></date_of_birth>
                    <land_line_number data-bind="text: land_line_number"></land_line_number>
                    <mobile_number data-bind="text: mobile_number"></mobile_number>
                </patient_details>
                <letter data-bind="with:letter">
                    <diagnosis data-bind="text:diagnosis"></diagnosis>
                    <consultant_name data-bind="text:consultant_name"></consultant_name>
                    <narrative data-bind="text:narrative"></narrative>
                </letter>
                <task_list data-bind="with:task_list">
                    <!-- ko foreach: task -->
                    <task>
                        <id data-bind="text:id"></id>
                        <description data-bind="text:description"></description>
                        <help_link data-bind="text:help_link"/>
                        <frequency data-bind="text:frequency"></frequency>
                        <next_due_date data-bind="text:next_due_date"></next_due_date>
                        <dates_action_taken data-bind="with:dates_action_taken">
                            <!-- ko foreach: date -->
                            <date data-bind="text: $data"></date>
                            <!-- /ko -->
                        </dates_action_taken>
                        <actions data-bind="with:actions">
                            <!-- ko foreach: action -->
                            <action>
                                <id data-bind="text:action_id"></id>
                                <trigger data-bind="text:trigger"></trigger>
                                <status data-bind="text:status"></status>
                                <result data-bind="text:result"></result>
                                <notes data-bind="text:notes"/>
                            </action>
                            <!-- /ko -->
                        </actions>
                    </task>
                    <!-- /ko -->
                </task_list>
                <guidance data-bind="text:guidance"/>
                <guidance_patient data-bind="text:guidance_patient"/>
                <references data-bind="with:references">
                <!-- ko foreach: reference -->
                    <reference>
                        <id data-bind="text:ref_id"/>
                        <description data-bind="text:ref_description"/>
                        <reference data-bind="text:ref_reference"/>                        
                    </reference>              
                    <!-- /ko -->
                </references>
            </active_letter>
            </div>
    </body>
</html>