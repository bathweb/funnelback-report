<!DOCTYPE html>
<html>
    <head>
        <title>
            Stats for www.bath.ac.uk/<?= $url ?>
        </title>
        <meta charset="UTF-8">
        <meta name="description" content="A script to get statistics about internal website and output them in wiki markup" />
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js">
        </script>
        <!--[if lt IE 9]>
            <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js">
            </script>
        <![endif]-->
        <script type="text/javascript" src="/common/js/kickstart/prettify.js">
        </script>
        <!-- PRETTIFY -->
        <script type="text/javascript" src="/common/js/kickstart/kickstart.js">
        </script>
        <!-- KICKSTART -->
        <link rel="stylesheet" type="text/css" href="/common/css/kickstart/kickstart.css" media="all" />
        <!-- KICKSTART -->
        <link rel="stylesheet" type="text/css" href="css/style.css" media="all" />
        <!-- CUSTOM STYLES -->
    </head>

    <body>
        <a id="top-of-page"></a>
        <div class="wrap clearfix">

            <div class="col_12">
                <h1>Funnelback search report</h1>
                <?php if (file_exists("report/usage-summary-chart.png")) { ?>
                    <img src="report/usage-summary-chart.png" width="100%">
                <?php } ?>

                <?php /*if (file_exists("report/monthly-usage-table.html")) {
                    echo file_get_contents("report/monthly-usage-table.html");
                }*/ ?>

                <?php if (file_exists("report/all_report.html")) {
                    echo file_get_contents("report/all_report.html");
                } ?>

            </div>

</body>
</html>
