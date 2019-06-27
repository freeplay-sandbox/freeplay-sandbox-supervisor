<style>
.statuses {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  grid-gap: 30px;
}
</style>

   <p>
    <!--<table class="table table-striped table-hover">-->
	<section class="statuses">
        {% for launcher in launchers %}
        {% include 'launcher.tpl' %}
        {% endfor %}
	</section>
    </p>

    <p>

    <a id="finalise-btn" class="orange darken-4 waves-effect waves-light btn" onclick="finalise()"><i class="material-icons">done</i> End session</a>

	</p>

    <div class="page-header">
        <h1>Nodes</h1>
    </div>
    <table class="table table-striped">
    <thead>
        <tr>
        <th>Status</th>
        <th>script</th>
        <th>not used</th>
        <th>not used</th>
        </tr>
    </thead>
    <tbody>
        {% for node in nodes_ok %}
        <tr>
            <td><span class="label label-success">Ok</span></td>
            <td>{{ "%s" % node}}</td>
            <td></td>
            <td></td>
        </tr>
        {% endfor %}
        {% for node in nodes_ko %}
        <tr>
            <td><span class="label label-warning">Not responsive</span></td>
            <td>{{ "%s" % node}}</td>
            <td></td>
            <td></td>
        </tr>
        {% endfor %}
    </tbody>
    </table>

<script>
function setarg(launchfile, arg, value) {
    $.ajax({
        url:'{{path}}?action=setarg&launch=' + launchfile + '&arg=' + arg + '&value=' + value,
        dataType: "html",
        context: this,
        success: function(data) {
                    $(this).parents("tr").replaceWith(data);
                }
        });
}

function finalise() {

    $("#finalise-btn").html('Stopping everything...');

    $.ajax({
        url:'{{path}}?action=finalise',
        dataType: "json",
        context: this,
        success: function(time) {
    	    $("#finalise-btn").html('Finished!');
            }
        });

}

function togglerunning(btn, isrunning) {
                    $(btn).toggleClass('green',!isrunning);
                    $(btn).toggleClass('red',isrunning);
                    $(btn).children().toggleClass('fa-stop', isrunning);

                    if(isrunning) {
                        $(btn).prop("value", "stop");
                    }
                    else {
                        $(btn).prop("value", "start");
                    }

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


function launch(launchfile, action) {
    $.ajax({
        url:'{{path}}?action=' + action + '&launch=' + launchfile,
        dataType: "json",
        context: this,
        success: function(isrunning) {
                    togglerunning(this, isrunning);
                }

        });
}

</script>

