<!DOCTYPE html>

<html>
<head>
    <title>Funnelback search report</title>
</head>
<body>
    <h1>Funnelback search report</h1>
    <?php if (file_exists("report/usage-summary-chart.png")) { ?>
        <img src="report/usage-summary-chart.png">
    <?php } ?>

    <?php if (file_exists("report/monthly-usage-table.html")) {
        echo file_get_contents("report/monthly-usage-table.html");
    } ?>

    <?php if (file_exists("report/all_report.html")) {
        echo file_get_contents("report/all_report.html");
    } ?>

</body>
</html>
