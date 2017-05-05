<div class="container">
    <div class="section">

        <div class="center row">

            <p>
                <button class="waves-effect waves-light btn-large" id="items_to_stash" alt="Items to stash"   onclick="perform('itemstostash')"><i class="fa fa-sign-in"></i> Interactive items to stash</button>
            </p>
            <p>
                <button class="waves-effect waves-light btn-large" id="reshuffle_items" alt="Reshuffle items" onclick="perform('reshuffleitems')"><i class="fa fa-random"></i> Reshuffle interactive items</button>
            </p>
            <p>
                <button class="waves-effect waves-light btn-large" id="clearing_bg" alt="Clearing background" onclick="perform('clearbackground')"><i class="fa fa-eraser"></i> Clear any drawings</button>
            </p>

        </div>
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

