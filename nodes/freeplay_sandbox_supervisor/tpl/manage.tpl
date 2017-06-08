<div class="container">
    <div class="section">
    <p>
        <div class="center row">
            <div class="col s6">
                <button style="margin:7px 0;width:80%" class="blue-grey waves-effect waves-light btn-large" alt="Blank screen" onclick="perform('blank')"><i class="fa fa-desktop"></i> Blank interface</button>
            </div>
            <div class="col s6">
                <button style="margin:7px 0;width:80%" class="amber waves-effect waves-light btn-large" alt="Visual tracking" onclick="perform('visualtracking')"><i class="fa fa-desktop"></i> Visual tracking</button>
            </div>            <div class="col s6">
                <button style="margin:7px 0;width:80%" class="lime waves-effect waves-light btn-large" alt="Tutorial" onclick="perform('tutorial')"><i class="fa fa-desktop"></i> Tutorial</button>
            </div>
            <div class="col s6">
                <button style="margin:7px 0;width:80%" class="amber waves-effect waves-light btn-large" alt="Freeplay" onclick="perform('freeplay')"><i class="fa fa-desktop"></i> Freeplay</button>
            </div>
            <div class="col s6">
                <button style="margin:7px 0;width:80%" class="amber waves-effect waves-light btn-large" alt="Items placement" onclick="perform('items-placement')"><i class="fa fa-desktop"></i> Items placement</button>
            </div>

        </div>

    </p>

    <p>
        <div class="center row">

            <div class="col s6">
                <button style="margin:7px 0;width:80%" class="waves-effect waves-light btn-large" alt="Items to stash"   onclick="perform('itemstostash')"><i class="fa fa-sign-in"></i> Interactive items to stash</button>
            </div>
            <div class="col s6">
                <button style="margin:7px 0;width:80%" class="waves-effect waves-light btn-large" alt="Reshuffle items" onclick="perform('reshuffleitems')"><i class="fa fa-random"></i> Reshuffle interactive items</button>
            </div>
            <div class="col s6">
                <button style="margin:7px 0;width:80%" class="waves-effect waves-light btn-large" alt="Clearing background" onclick="perform('clearbackground')"><i class="fa fa-eraser"></i> Clear any drawings</button>
            </div>
            <div class="col s6">
                <button style="margin:7px 0;width:80%" class="waves-effect waves-light btn-large" alt="Trigger robot localisation" onclick="perform('localisation')"><i class="fa fa-compass"></i> Trigger robot localisation</button>
            </div>

        </div>
        </p>
    </div>
</div>

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

</script>

