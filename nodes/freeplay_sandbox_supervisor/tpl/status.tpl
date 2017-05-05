    <p>
    <table class="table table-striped table-hover">
    <thead>
        <tr>
        <th style="width: 50px"></th>
        <th style="width: 400px"></th>
        <th style="width: 50px"></th>
        <th></th>
        </tr>
    </thead>
    <tbody>
        {% for launcher in launchers %}
        {% include 'launcher.tpl' %}
        {% endfor %}
    </tbody>
    </table>
    </p>

    <div class="page-header">
        <h1>Nodes</h1>
    </div>
    <table class="table table-striped">
    <thead>
        <tr>
        <th>Status</th>
        <th>ROS node</th>
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

function updaterunningstate() {
    $.ajax({
        url:'{{path}}?action=updatestate',
        dataType: "json",
        context: this,
        success: function(runningstates) {
                for (var l in runningstates) {
                    togglerunning($("#"+l+"_startstop")[0], runningstates[l]);
                    }

                }
        });
}

var intervalID = window.setInterval(updaterunningstate, 1000);

</script>

