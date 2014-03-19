<!DOCTYPE html>
<html>
    <head>
        <title>Stats for www.bath.ac.uk
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
                <h1>Funnelback search report ALPHA</h1>
                <?php
                    if (!isset($_GET["reportname"])) {
                        $reports = scandir('reports');

                        foreach ($reports as $reportdir) {
                            if(strpos($reportdir, ".")===FALSE) {
                                print("<li><a href='index.php?reportname=".$reportdir."'>".$reportdir."</a></li>");
                            }
                        }

                    } else {
                        $reportname = $_GET["reportname"];

                        if (dirname($reportname) != '.') die ('Directory traversal is not permitted');

                        if (file_exists("reports/".$reportname."/usage-summary-chart.png")) {
                            echo("<img src='reports/".$reportname."/usage-summary-chart.png' width='100%''>");
                        }

                        if (file_exists("reports/".$reportname."/all_report.html")) {
                            echo(file_get_contents("reports/".$reportname."/all_report.html"));
                        }
                    }

                ?>

            </div> <!-- /col_12 -->
        </div> <!-- /wrap -->
    </body>
</html>

