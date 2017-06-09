
        <div class="container">
            <div class="section">
              <div id="interactive_playground_chip" class="chip">
                  <i class="material-icons" style="vertical-align:middle">surround_sound</i>
                  interactive_playground
              </div>
              <div id="dual_sr300_chip" class="chip">
                  <i class="material-icons" style="vertical-align:middle">videocam</i>
                  dual_sr300
              </div>
              <div id="dual_attention_tracking_chip" class="chip">
                  <i class="material-icons" style="vertical-align:middle">visibility</i>
                  dual_attention_tracking
              </div>
              <div id="prepare_recording_chip" class="chip">
                  <i class="material-icons" style="vertical-align:middle">videocam</i>
                  prepare_recording
              </div>
            </div>

            <div class="section">
            <h3>New record</h3> {{ freespace }}
                
                <p>
                <span id="record-id"></span>
                </p>

                <div class="center row">
                <a id="childchildbtn" class="waves-effect waves-light btn" onclick="setcondition('childchild')">Child-child</a>
                <a id="childrobotbtn" class="waves-effect waves-light btn" onclick="setcondition('childrobot')">Child-robot</a>
                </div>

                <div class="row">
                    <div id="purple-participant" class="col s12 m6" style="display:none;">
                        <div class="icon-block">

                            <form action="#">
                                <fieldset id="purple-form">

                                <h2 class="center deep-purple-text"><i class="large material-icons">person_pin</i></h2>

                                <strong>ID: <span id="purple-id"></span></strong>

                                <h5>General</h5>
                                <p>
                                <input name="purple-gender" checked type="radio" value="male" id="purple-male" />
                                <label for="purple-male">Male</label>
                                <input name="purple-gender" type="radio" value="female" id="purple-female" />
                                <label for="purple-female">Female</label>
                                </p>

                                <p class="range-field">
                                <label for="purple-age">Age</label>
                                <input type="range" id="purple-age" min="3" max="8" />
                                </p>

                                <h5>Tablet familiarity</h5>
                                <p>
                                <input name="purple-tablet-familiarity" type="radio" value="na" id="purple-notknow" checked />
                                <label for="purple-notknown">Not known</label>
                                <input name="purple-tablet-familiarity" type="radio" value="0" id="purple-notfamiliar" />
                                <label for="purple-notfamiliar">Not familiar</label>
                                <input name="purple-tablet-familiarity" type="radio" value="1" id="purple-somewhat-familiar" />
                                <label for="purple-somewhat-familiar">Somewhat familiar</label>
                                <input name="purple-tablet-familiarity" type="radio" value="2" id="purple-familiar" />
                                <label for="purple-familiar">Familiar</label>
                                </p>

                                </fieldset>

                                <div class="center" style="margin-top:15px">
                                <div id="nb_purple_faces_chip" class="chip"><i class="material-icons" style="vertical-align:middle">supervisor_account</i><span id="nb_purple_faces">no detection yet</span></div>
                                </div>

                            </form>
                        </div>
                    </div>

                    <div id="yellow-participant" class="col s12 m6" style="display:none;">
                        <div class="icon-block">

                            <form action="#">
                                <fieldset id="yellow-form">
                                <h2 class="center amber-text"><i class="large material-icons">person_pin</i></h2>
                                <strong>ID: <span id="yellow-id"></span></strong>
                                <h5>General</h5>
                                <p>
                                <input name="yellow-gender" checked type="radio" value="male" id="yellow-male" />
                                <label for="yellow-male">Male</label>
                                <input name="yellow-gender" type="radio" value="female" id="yellow-female" />
                                <label for="yellow-female">Female</label>
                                </p>

                                <p class="range-field">
                                <label for="yellow-age">Age</label>
                                <input type="range" id="yellow-age" min="3" max="8" />
                                </p>

                                <h5>Tablet familiarity</h5>
                                <p>
                                <input name="yellow-tablet-familiarity" type="radio" value="na" id="yellow-notknow" checked />
                                <label for="yellow-notknown">Not known</label>
                                <input name="yellow-tablet-familiarity" type="radio" value="0" id="yellow-notfamiliar" />
                                <label for="yellow-notfamiliar">Not familiar</label>
                                <input name="yellow-tablet-familiarity" type="radio" value="1" id="yellow-somewhat-familiar" />
                                <label for="yellow-somewhat-familiar">Somewhat familiar</label>
                                <input name="yellow-tablet-familiarity" type="radio" value="2" id="yellow-familiar" />
                                <label for="yellow-familiar">Familiar</label>
                                </p>

                                </fieldset>

                                <div class="center" style="margin-top:15px">
                                <div id="nb_yellow_faces_chip" class="chip"><i class="material-icons" style="vertical-align:middle">supervisor_account</i><span id="nb_yellow_faces">no detection yet</span></div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>

                <div id="participant-next-btn" class="center row" style="display:none;">
                    <a id="participant-next-btn-link" class="waves-effect waves-light btn disabled" onclick="demographics_done()">Waiting for faces to be detected</a>
                </div>

                <div id="visual-tracking" class="center row" style="display:none;">


                    <p>
                    <div id="record_visual_tracking_chip" class="center chip">
                        <i class="material-icons" style="vertical-align:middle">voicemail</i>
                        record_visual_tracking
                    </div>
                    </p>

                    <a id="visual-tracking-btn" class="waves-effect waves-light btn" onclick="start_visual_tracking()">Start visual tracking task</a>
                    <a class="waves-effect waves-teal btn-flat" onclick="$('#tutorial').show()">Skip</a>

                    <p>
                    <div id="visual-tracking-spinner" class="preloader-wrapper active" style="display:none;">
                        <div class="spinner-layer spinner-red-only">
                        <div class="circle-clipper left">
                            <div class="circle"></div>
                        </div><div class="gap-patch">
                            <div class="circle"></div>
                        </div><div class="circle-clipper right">
                            <div class="circle"></div>
                        </div>
                        </div>
                    </div>
                    </p>
                </div>

                <div id="tutorial" class="center row" style="display:none;">
                    <a id="tutorial-btn" class="waves-effect waves-light btn" onclick="start_tutorial()">Start tutorial</a>
                    <a class="waves-effect waves-teal btn-flat" onclick="$('#items-placement').show()">Skip</a>
                </div>

                <div id="items-placement" class="center row" style="display:none;">
                    <a id="items-placement-btn" class="waves-effect waves-light btn" onclick="start_items_placement()">Start Items placement</a>
                    <a class="waves-effect waves-teal btn-flat" onclick="$('#freeplay').show()">Skip</a>
                    <p id="items-placement-btns" style="display:none">
                    <a id="screenshot-btn" class="amber waves-effect waves-light btn" onclick="perform('screenshot',{'prefix':'items-placement'})"><i class="fa fa-desktop"></i> screenshot</a>
                    </p>
                </div>

                <div id="freeplay" class="center row" style="display:none;">
                    <p>
                    <div id="record_chip" class="center chip">
                        <i class="material-icons" style="vertical-align:middle">voicemail</i>
                        record
                    </div>
                    </p>
                    <a id="freeplay-btn" class="waves-effect waves-light btn" onclick="start_freeplay()">Start freeplay task</a>
                    <a id="stop-freeplay-btn" style="display:none" class="waves-effect waves-light btn" onclick="stop_freeplay()">Stop</a>

                    <p id="freeplay-elapsed-time" style="display:none"></p>

                    <p id="marker-btns" style="display:none">
                    <a id="note-btn" class="waves-effect waves-light btn" onclick="add_marker('note')"><i class="material-icons">mode_edit</i></a>
                    <a id="interesting-btn" class="light-green waves-effect waves-light btn" onclick="add_marker('interesting')"><i class="material-icons">thumb_up</i></a>
                    <a id="issue-btn" class="amber waves-effect waves-light btn" onclick="add_marker('issue')"><i class="material-icons">new_releases</i></a>
                    <a id="screenshot-btn" class="amber waves-effect waves-light btn" onclick="add_marker('screenshot')"><i class="fa fa-desktop"></i></a>

                    <p id="marker_info"></p>
                    </p>
                </div>

            </div>
<!--
            <div class="section">

            <h3> Past records </h3>

            <table class="table table-striped">
            <thead>
                <tr>
                <th>#</th>
                <th>Date</th>
                <th>Condition</th>
                <th>Age</th>
                <th>Path</th>
                </tr>
            </thead>
            <tbody>
                {% for record in records %}
                <tr>
                    <td>{{ "%s" % loop.index}}</td>
                    <td>{{ "%s" % record["date"]}}</td>
                    <td>{{ "%s" % record["condition"]}}</td>
                    <td>{{ "%s" % record["age"]}}</td>
                    <td>{{ "%s" % record["path"]}}</td>
                </tr>
                {% endfor %}
            </tbody>
            </table>

        </div>
-->
</div>
<script>

var condition = "";
var current_recordid = "";

function perform(action, parameters) {

    var url = '{{path}}?action=' + action;

    // if parameters provided, turn them into a query string
    url = (typeof parameters !== 'undefined') ?  url + "&" + $.param(parameters) : url;

    if(current_recordid !== "") {url = url +  "&recordid=" + current_recordid;}

    $.ajax({
        url: url,
        dataType: "json",
        context: this,
        success: function(msg) {
            console.log(msg);
            }

        });
}


function setcondition(cdt) {

    initiate_experiment(cdt);

    //console.log(this); // points to the clicked input button
    //perform(this.id)


    condition = cdt;

    if (cdt === "childchild") {
        $("#childrobotbtn").addClass("disabled");
        $("#purple-participant").show();
        $("#yellow-participant").show();
    }
    else {
        $("#childchildbtn").addClass("disabled");
        $("#purple-participant").show();
    }

    $("#participant-next-btn").show();
    startUpdateFaces();
}

function initiate_experiment(cdt) {
    $.ajax({
        url:'{{path}}?action=initiate_experiment&cdt=' + cdt,
        dataType: "json",
        context: this,
        success: function(ids) {
            current_recordid = ids[0];
            $("#record-id").html("Record id " + current_recordid + " created");
            $("#purple-id").html(ids[1]);
            $("#yellow-id").html(ids[2]);

            // once the experiment is created, we know ROS logging is
            // configured to store log files into the experiment directory
            // we can then start the ROS nodes
            perform("start_sandbox");
            perform("start_cameras");
            perform("start_attention_tracking");

            }
        });

}

function demographics_done() {

    $("#purple-form").prop("disabled","true");
    $("#yellow-form").prop("disabled","true");
    $("#participant-next-btn").hide();


    var experiment = {
        "condition": condition,
        "purple-gender": $('input[name=purple-gender]:checked').val(),
        "purple-age": $("#purple-age").val(),
        "purple-tablet-familiarity": $('input[name=purple-tablet-familiarity]:checked').val(),
        "yellow-gender": $('input[name=yellow-gender]:checked').val(),
        "yellow-age": $("#yellow-age").val(),
        "yellow-tablet-familiarity": $('input[name=yellow-tablet-familiarity]:checked').val(),
        }


    $.ajax({
        url:'{{path}}?action=savedemographics&recordid=' + current_recordid +  '&' + $.param(experiment),
        dataType: "json",
        context: this,
        success: function(done) {
            $("#visual-tracking").show();
            }
        });
}

function updaterunningstate() {
    $.ajax({
        url:'{{path}}?action=updatestate',
        dataType: "json",
        context: this,
        success: function(runningstates) {
                for (var l in runningstates) {

                    /////// status' page!
                    togglerunning($("#"+l+"_startstop")[0], runningstates[l]);
                    ///////

                    if($("#"+l+"_chip").length) {
                        if(runningstates[l]) {
                            $("#"+l+"_chip").css("background-color", "#c4eab0");
                        }
                        else {
                            $("#"+l+"_chip").css("background-color", "#eac2b0");
                        }
                    }
                }
            }
        });
}

var stateUpdater = window.setInterval(updaterunningstate, 1000);

var elapsedTime = 0;
var elapsedTimeTimer = window.setInterval(function(){
                elapsedTime++;
                var secs = elapsedTime % 60;
                $("#freeplay-elapsed-time").html("Elapsed time: " + Math.floor(elapsedTime/60) + ":" + (secs > 9 ? "":"0") + secs);
                },1000);

var faceDetectorInterval;

function startUpdateFaces() {
    faceDetectorInterval = setInterval(updatedetectedfaces, 1000);
}

function stopUpdateFaces() {
    clearInterval(faceDetectorInterval);
}

function updatedetectedfaces() {
    $.ajax({
        url:'{{path}}?action=getdetectedfaces',
        dataType: "json",
        context: this,
        success: function(faces) {
               $("#nb_purple_faces").html(faces["purple"] + " face(s) detected");
               $("#nb_purple_faces_chip").toggleClass('green-text',faces["purple"] == 1);
               $("#nb_purple_faces_chip").toggleClass('red-text',faces["purple"] != 1);

               $("#nb_yellow_faces").html(faces["yellow"] + " face(s) detected");
               $("#nb_yellow_faces_chip").toggleClass('green-text',faces["yellow"] == 1);
               $("#nb_yellow_faces_chip").toggleClass('red-text',faces["yellow"] != 1);


               if (condition === "childchild") {
                if (faces["yellow"] == 1 && faces["purple"] == 1) {
                        //stopUpdateFaces();
                        //$("#nb_yellow_faces_chip").hide();
                        //$("#nb_purple_faces_chip").hide();
                        $("#participant-next-btn-link").removeClass('disabled');
                        $("#participant-next-btn-link").html('Save demographics');
                }
                }
               else { // cdt: child-robot
                if (faces["purple"] == 1) {
                        //stopUpdateFaces();
                        //$("#nb_purple_faces_chip").hide();
                        $("#participant-next-btn-link").removeClass('disabled');
                        $("#participant-next-btn-link").html('Save demographics');
                }
               }
            }
        });
}


function start_visual_tracking() {
    console.log("Starting visual tracking");
    
    $("#visual-tracking-btn").addClass('disabled');
    $("#visual-tracking-btn").html('Running...');
    $("#visual-tracking-spinner").show();

    $.ajax({
        url:'{{path}}?action=start_visual_tracking&recordid=' + current_recordid,
        dataType: "json",
        context: this,
        success: function(done) {
            $("#visual-tracking-btn").html('Visual tracking: completed');
            $("#visual-tracking-spinner").hide();
            $("#tutorial").show();
            }
        });
}

function start_tutorial() {
    console.log("Starting tutorial");
    
    $("#tutorial-btn").addClass('disabled');
    $("#tutorial-btn").html('Starting...');

    $.ajax({
        url:'{{path}}?action=tutorial',
        dataType: "json",
        context: this,
        success: function(done) {
            $("#tutorial-btn").html('Tutorial: started');
            $("#items-placement").show();
            }
        });
}

function start_items_placement() {
    console.log("Starting items placement");
    
    $("#items-placement-btn").addClass('disabled');
    $("#items-placement-btn").html('Starting...');

    $.ajax({
        url:'{{path}}?action=items-placement',
        dataType: "json",
        context: this,
        success: function(done) {
            $("#items-placement-btn").html('Items placement: started');
            $("#items-placement-btns").show();
            $("#freeplay").show();
            }
        });
}

function start_freeplay() {
    console.log("Starting freeplay");
    
    $("#items-placement-btns").hide();
    $("#freeplay-btn").addClass('disabled');
    $("#freeplay-btn").html('Starting...');

    $.ajax({
        url:'{{path}}?action=start_freeplay&recordid=' + current_recordid,
        dataType: "json",
        context: this,
        success: function(done) {
            $("#freeplay-btn").html('Freeplay: started');

            // reset timer
            elapsedTime = 0;
            $("#freeplay-elapsed-time").show();

            $("#stop-freeplay-btn").show();
            $("#marker-btns").show();
            }
        });
}

function stop_freeplay() {
    console.log("Stopping freeplay");
    
    $("#stop-freeplay-btn").addClass('disabled');
    $("#marker-btns").hide();
    $("#marker_info").hide();
    $("#stop-freeplay-btn").html('Stopping...');

    $.ajax({
        url:'{{path}}?action=stop_freeplay',
        dataType: "json",
        context: this,
        success: function(done) {
            $("#stop-freeplay-btn").html('End of the study!');
            clearInterval(elapsedTimeTimer);
            var secs = elapsedTime % 60;
            $("#freeplay-elapsed-time").html("<strong>Total time: " + Math.floor(elapsedTime/60) + ":" + (secs > 9 ? "":"0") + secs + "</strong>");
            }
        });
}

function add_marker(type) {
    console.log("Adding marker (" + type + ")");

    $.ajax({
        url:'{{path}}?action=add_marker&recordid=' + current_recordid + '&type=' + type,
        dataType: "json",
        context: this,
        success: function(time) {
            if (type==="screenshot") {
                perform('screenshot',{'prefix':'freeplay-' + time});
            }
            $("#marker_info").html('Marker <strong>' + type + '</strong> added. Timestamp: <strong>' + time + '</strong>');
            }
        });
}

</script>

