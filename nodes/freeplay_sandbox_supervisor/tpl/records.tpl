
        <div class="container">
            <div class="section">
              <div id="interactive_playground_chip" class="chip">
                  <i class="material-icons">surround_sound</i>
                  sandbox
              </div>
              <div id="dual_sr300_chip" class="chip">
                  <i class="material-icons">videocam</i>
                  cameras
              </div>
            </div>

            <div class="section">
            <h3>New record</h3> {{ freespace }}
                

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
                                <p>
                                <input name="purple-gender" type="radio" value="male" id="purple-male" />
                                <label for="purple-male">Male</label>
                                <input name="purple-gender" type="radio" value="female" id="purple-female" />
                                <label for="purple-female">Female</label>
                                </p>

                                <p class="range-field">
                                <label for="purple-age">Age</label>
                                <input type="range" id="purple-age" min="3" max="8" />
                                </p>

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

                                <p>
                                <div id="nb_purple_faces_chip" class="chip"><i class="material-icons">person_pin</i><span id="nb_purple_faces">0</span></div>
                                </p>
                                </fieldset>

                            </form>
                        </div>
                    </div>

                    <div id="yellow-participant" class="col s12 m6" style="display:none;">
                        <div class="icon-block">

                            <form action="#">
                                <fieldset id="yellow-form">
                                <h2 class="center amber-text"><i class="large material-icons">person_pin</i></h2>
                                <p>
                                <input name="yellow-gender" type="radio" value="male" id="yellow-male" />
                                <label for="yellow-male">Male</label>
                                <input name="yellow-gender" type="radio" value="female" id="yellow-female" />
                                <label for="yellow-female">Female</label>
                                </p>

                                <p class="range-field">
                                <label for="yellow-age">Age</label>
                                <input type="range" id="yellow-age" min="3" max="8" />
                                </p>

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

                                <p>
                                <div id="nb_yellow_faces_chip" class="chip"><i class="material-icons">person_pin</i><span id="nb_yellow_faces">0</span></div>
                                </p>
                                </fieldset>

                            </form>
                        </div>
                    </div>
                </div>

                <div id="participant-next-btn" class="center row" style="display:none;">
                    <a class="waves-effect waves-light btn" onclick="demographics_done()">Next</a>
                </div>

                <div id="face-detection-check" class="center row" style="display:none;">

                    <h5>Good! Record ID <span id="record-id"></span> created. Let's run some checks</h5>
                    <p>Sit the children so that the cameras can see them
                    </p>
                    <a id="face-check-btn" class="waves-effect waves-light btn" onclick="face_check_done()">No face detected yet</a>
                </div>

                <div id="visual-tracking" class="center row" style="display:none;">

                    <h5>Let's start! First, visual tracking</h5>
                    <a class="waves-effect waves-light btn" onclick="start_visual_tracking()">Start visual tracking task</a>
                </div>


            </div>

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
</div>
<script>

var condition = "";

function perform(action, parameters) {

    var url = '{{path}}?action=' + action;

    // if parameters provided, turn them into a query string
    url = (typeof parameters !== 'undefined') ?  url + "&" + $.param(parameters) : url;

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
    //console.log(this); // points to the clicked input button
    //perform(this.id)

    perform("start_sandbox");
    perform("start_cameras");

    condition = cdt;

    $("#participant-next-btn").show();
    if (cdt === "childchild") {
        $("#childrobotbtn").addClass("disabled");
        $("#purple-participant").show();
        $("#yellow-participant").show();
    }
    else {
        $("#childchildbtn").addClass("disabled");
        $("#purple-participant").show();
    }
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
        "yellow-age": $("#ywllow-age").val(),
        "yellow-tablet-familiarity": $('input[name=yellow-tablet-familiarity]:checked').val(),
        }


    $.ajax({
        url:'{{path}}?action=createrecord&' + $.param(experiment),
        dataType: "json",
        context: this,
        success: function(recordid) {
            $("#record-id").html(recordid);
            $("#face-detection-check").show();
            }

        });


}

function face_check_done() {

    $("#face-detection-check").hide();
    $("#visual-tracking").show();
}


function updaterunningstate() {
    $.ajax({
        url:'{{path}}?action=updatestate',
        dataType: "json",
        context: this,
        success: function(runningstates) {
                for (var l in runningstates) {
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

var intervalID = window.setInterval(updaterunningstate, 1000);

function updatedetectedfaces() {
    $.ajax({
        url:'{{path}}?action=getdetectedfaces',
        dataType: "json",
        context: this,
        success: function(faces) {
               $("#nb_purple_faces").html(faces["purple"]);
               $("#nb_purple_faces_chip").toggleClass('green-text',faces["purple"] == 1);
               $("#nb_purple_faces_chip").toggleClass('red-text',faces["purple"] != 1);

               $("#nb_yellow_faces").html(faces["yellow"]);
               $("#nb_yellow_faces_chip").toggleClass('green-text',faces["yellow"] == 1);
               $("#nb_yellow_faces_chip").toggleClass('red-text',faces["yellow"] != 1);
            }
        });
}

var intervalID = window.setInterval(updatedetectedfaces, 1000);



</script>

