/*
    function Contact(id) {
        var self = this;
        self.id = ko.observable(id);
    }
    
    function Action() {
        var self = this;
        
        self.id = ko.observable();
        
        self.trigger = ko.observable();
        
        self.status = ko.observable();
        
        self.result = ko.observable();
        
        self.notes = ko.observableArray([]);
    }
    
    function Task() {
        var self = this;
        
        self.description = ko.observable();
        
        self.helpLink = ko.observable();
        
        self.frequency = ko.observable();
        
        self.nextDueDate = ko.observable();
        
        self.datesActionTaken = ko.observableArray([]);
        
        self.actions = ko.observableArray([]);
        
        self.newAction = function() {
            self.actions.push(new Action());
        }
    }
    
    function Letter() {
        var self = this;
        
        self.diagnosis = ko.observable();
        
        self.consultantName = ko.observable();
        
        self.narrative = ko.observable();
    }
    
    function PatientDetails() {
        var self = this;
        
        self.NHSNumber = ko.observable();
        
        self.hospitalNumber = ko.observable();
        
        self.surname = ko.observable();
        
        self.forename = ko.observable();
        
        self.addressLine1 = ko.observable();
        
        self.addressLine2 = ko.observable();
        
        self.addressLine3 = ko.observable();
        
        self.postCode = ko.observable();
        
        self.preferredEmailAddress = ko.observable();
        
        self.dob = ko.observable();
        
    }
    
    function ActiveLetter() {
        var self = this;
        
        self.topicOfLetter = ko.observable();
        
        self.contacts = ko.observableArray([]);
        
        self.patient = new PatientDetails();
        
        self.letter = new Letter();
        
        self.tasks = ko.observableArray([]);
    }
*/    
    var vm = null;
    $(document).ready(function() {
        function ActiveLetter() {
            var self = this;
            
            self.data = ko.mapping.fromJS({});
            
            self.addContact = function(model) {
                model.contact.push({id: ko.observable()});
            }
            
            self.removeContact = function(model) {
                self.data.contact_details.contact.remove(model);
            }
            
            self.addTask = function(model) {
                
                model.task_list.task.push({
                    id: ko.observable(), 
                    description: ko.observable(), 
                    help_link: ko.observable(),
                    frequency: ko.observable(),
                    next_due_date: ko.observable(),
                    dates_action_taken: { date: ko.observableArray() },
                    actions: { action: ko.observableArray([{
                        trigger: ko.observable(),
                        status: ko.observable(),
                        result: ko.observable(),
                        notes: ko.observable()
                    }])}
                });
            }
            
            self.removeTask = function(model) {
                self.data.task_list.task.remove(model);
            }
            
            self.addDate = function(model) {
                model.dates_action_taken.date.push(ko.observable());
            }
            
            self.removeDate = function(parent, model) {
                parent.date.remove(model);
            }
            
            self.addAction = function(model) {
                model.actions.action.push({
                        id: ko.observable(),
                        trigger: ko.observable(),
                        status: ko.observable(),
                        result: ko.observable(),
                        notes: ko.observable()
                    });
            }
            
            self.removeAction = function(parent, model) {
                parent.action.remove(model);
            }
            
            self.addReference = function(model) {
                model.references.reference.push(ko.observable());
            }
            
            self.removeReference = function(parent, model) {
                parent.reference.remove(model);
            }
            
            self.submit = function() {
                var url = "submit.xql";
                var b = "data=" + $('#instance').html();
                b = b.replace(/ data-bind=".*"/g, "");
                b = b.replace(/\<!\-\- \/ko \-\-\>/g, "");
                b = b.replace(/\<!\-\- ko .* \-\-\>/g, "");
                
                if (typeof(id) !== "undefined") {
                    //b = b + "&id=" + id;
                    url += "?id=" + id
                }
                
                //console.log(b);
                
                $.post(url, b, function(data) {
                    $('#server-message a').html(data).attr("href", data);
                }, "xml").error(function(x, s, e) {$('#server-message a').html(x.responseText).attr("href", x.responseText);});
                
                /*
                $.ajax({
                  type: "POST",
                  url: url,
                  data: b,
                  processData: false,
                  success: function(data, textStatus, jqXHR) {$('#server-message').html(data);}
                }, "xml").error(function(x, s, e) {$('#server-message').html(x.responseText);});*/
            }
        }
        
        
        if (typeof(id) !== "undefined") {
            $.getJSON('/exist/apps/activeletter/data.xql?id=' + id, function(data, s, x) {
                vm = new ActiveLetter(); 
                ko.mapping.fromJS(data, vm.data);
                ko.applyBindings(vm);
                
                $('#qc').qrcode("http://cg2.cs.ox.ac.uk:8080/exist/apps/activeletter/create?id=" + id);
            }, "json").error(function(x, s, e){
                console.log(s);
                console.log(e);
            });
        }
        else {
            $.getJSON('/exist/apps/activeletter/data.xql', function(data, s, x) {
                vm = new ActiveLetter(); 
                ko.mapping.fromJS(data, vm.data);
                ko.applyBindings(vm);
            }, "json").error(function(x, s, e){
                console.log(s);
                console.log(e);
            });
        }

    });
