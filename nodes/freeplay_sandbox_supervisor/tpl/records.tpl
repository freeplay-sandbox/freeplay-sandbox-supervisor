        <h3 class="center">New record</h3>

        <div class="container">
            <div class="section">

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
                                <input name="purple-age" type="radio" id="purple-male" />
                                <label for="purple-male">Male</label>
                                <input name="purple-age" type="radio" id="purple-female" />
                                <label for="purple-female">Female</label>
                                </p>

                                <p class="range-field">
                                <label for="purple-age">Age</label>
                                <input type="range" id="purple-age" min="3" max="8" />
                                </p>

                                <p>
                                <input name="purple-tablet-familiarity" type="radio" id="purple-notknow" checked />
                                <label for="purple-notknown">Not known</label>
                                <input name="purple-tablet-familiarity" type="radio" id="purple-notfamiliar" />
                                <label for="purple-notfamiliar">Not familiar</label>
                                <input name="purple-tablet-familiarity" type="radio" id="purple-somewhat-familiar" />
                                <label for="purple-somewhat-familiar">Somewhat familiar</label>
                                <input name="purple-tablet-familiarity" type="radio" id="purple-familiar" />
                                <label for="purple-familiar">Familiar</label>
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
                                <input name="yellow-age" type="radio" id="yellow-male" />
                                <label for="yellow-male">Male</label>
                                <input name="yellow-age" type="radio" id="yellow-female" />
                                <label for="yellow-female">Female</label>
                                </p>

                                <p class="range-field">
                                <label for="yellow-age">Age</label>
                                <input type="range" id="yellow-age" min="3" max="8" />
                                </p>

                                <p>
                                <input name="yellow-tablet-familiarity" type="radio" id="yellow-notknow" checked />
                                <label for="yellow-notknown">Not known</label>
                                <input name="yellow-tablet-familiarity" type="radio" id="yellow-notfamiliar" />
                                <label for="yellow-notfamiliar">Not familiar</label>
                                <input name="yellow-tablet-familiarity" type="radio" id="yellow-somewhat-familiar" />
                                <label for="yellow-somewhat-familiar">Somewhat familiar</label>
                                <input name="yellow-tablet-familiarity" type="radio" id="yellow-familiar" />
                                <label for="yellow-familiar">Familiar</label>
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

                    <h5>Good! Let's run some checks</h5>
                    <p>Sit the children so that the cameras can see them
                    </p>
                    <a id="face-check-btn" class="waves-effect waves-light btn" onclick="face_check_done()">No face detected yet</a>
                </div>

                <div id="visual-tracking" class="center row" style="display:none;">

                    <h5>Let's start! First, visual tracking</h5>
                    <a class="waves-effect waves-light btn" onclick="start_visual_tracking()">Start visual tracking task</a>
                </div>


            </div>
        </div>


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

<script>


function perform(action) {
    $.ajax({
        url:'{{path}}?action=' + action,
        dataType: "json",
        context: this,
        success: function(isrunning) {
                    $(this).toggleClass('btn-primary', 'btn-secondary');
                }

        });
}


function setcondition(cdt) {
    //console.log(this); // points to the clicked input button
    //perform(this.id)

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
    $("#face-detection-check").show();

}

function face_check_done() {

    $("#face-detection-check").hide();
    $("#visual-tracking").show();
}
</script>

