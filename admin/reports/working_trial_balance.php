<?php
function format_num($number)
{
    $decimals = 0;
    $num_ex = explode('.', $number);
    $decimals = isset($num_ex[1]) ? strlen($num_ex[1]) : 0;
    return number_format($number, 2);
}
function getfinancialYear($YearStart, $YearEnd)
{
    return date("Y", strtotime($YearStart))  . '-' . date("Y", strtotime($YearEnd));
}
function getfinancialStartYear($Year)
{
    return "{$Year}-04-01";
}
function getfinancialEndYear($Year)
{
    return "{$Year}-03-31";
}
$financialYearStart =  getfinancialStartYear(date("Y")); // Get the current year
$financialYearEnd = getfinancialEndYear(date("Y") + 1);
$from = isset($_GET['from']) ? $_GET['from'] :  $financialYearStart;
$to = isset($_GET['to']) ? $_GET['to'] : $financialYearEnd;
$financialYear = getfinancialYear($financialYearStart, $financialYearEnd);
$id = $_settings->userdata('id');
?>
<style>
    th.p-0,
    td.p-0 {
        padding: 0 !important;
    }
</style>
<div class="card card-outline card-primary">
    <div class="card-header">
        <h3 class="card-title">Working Trial Balance for financial Year: <?= $financialYear  ?></h3>
        <div class="card-tools">
        </div>
    </div>
    <div class="card-body">
        <div class="callout border-primary shadow rounded-0">
            <h4 class="text-muted">Filter Date</h4>
            <form action="" id="filter">
                <div class="row align-items-end">
                    <div class="col-md-4 form-group">
                        <label for="from" class="control-label">Date From</label>
                        <input type="date" id="from" name="from" value="<?= $from ?>" class="form-control form-control-sm rounded-0">
                    </div>
                    <div class="col-md-4 form-group">
                        <label for="to" class="control-label">Date To</label>
                        <input type="date" id="to" name="to" value="<?= $to ?>" class="form-control form-control-sm rounded-0">
                    </div>
                    <div class="col-md-4 form-group">
                        <button class="btn btn-default bg-gradient-navy btn-flat btn-sm"><i class="fa fa-filter"></i> Filter</button>
                        <button class="btn btn-default border btn-flat btn-sm" id="print" type="button"><i class="fa fa-print"></i> Print</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="container-fluid" id="outprint">
            <h3 class="text-center"><b><?= $_settings->info('name') ?></b></h3>
            <h4 class="text-center"><b>Working Trial Balance</b></h4>
            <?php if ($from == $to) : ?>
                <p class="m-0 text-center"><?= date("M d, Y", strtotime($from)) ?></p>
            <?php else : ?>
                <p class="m-0 text-center"><?= date("M d, Y", strtotime($from)) . ' - ' . date("M d, Y", strtotime($to)) ?></p>
            <?php endif; ?>
            <hr>
            <table class="table table-hover table-bordered">
                <thead>
                    <tr>
                        <th class="text-left">Account Name</th>
                        <th class="text-left">debit</th>
                        <th class="text-left">Credit</th>
                        <!-- <th class="text-left">Balance</th> -->
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $balance = 0;
                    $groupBalance = 0;
                    $groupByAccountByBalance = [];
                    $groupByAccount = $conn->query("select g.id AS group_id,
                    g.name AS group_name,
                    al.id AS account_id,
                    al.name AS account_name,
                    COALESCE(SUM(CASE WHEN ji.type = 1 THEN ji.amount ELSE 0 END), 0) AS total_debit,
                    COALESCE(SUM(CASE WHEN ji.type = 2 THEN ji.amount ELSE 0 END), 0) AS total_credit,
                    COALESCE(SUM(CASE WHEN ji.type = 1 THEN ji.amount ELSE -ji.amount END), 0) AS balance
                FROM
                    journal_items ji
                JOIN
                    group_list g ON ji.group_id  = g.id
                LEFT JOIN
                    account_list al  ON ji.account_id  = al.id
                WHERE ji.journal_id IN (SELECT id FROM journal_entries where user_id = '{$id}' and date(journal_date) BETWEEN '{$from}' and '{$to}' )
                and g.id  NOT IN (9,10)
                GROUP BY
                    g.id, al.id
                ORDER BY
                    g.id, al.id");
                    while ($arow = $groupByAccount->fetch_assoc()) {
                        $groupByAccountByBalance[$arow['group_name']][] = $arow;
                        $balance += $arow['balance'];
                    }
                    $groupNames = array_keys($groupByAccountByBalance);
                    $i = 0;

                    while (isset($groupNames[$i])) :
                        $groupName = $groupNames[$i];
                        $i++;
                    ?>
                        <tr>
                            <th colspan="4" class="text-left"><?= $groupName ?></th>
                        </tr>
                        <?php
                        $groupBalance = 0;
                        $Accounts = $groupByAccountByBalance[$groupName];
                        $j = 0;
                        while (isset($Accounts[$j])) :
                            $accountRow = $Accounts[$j];
                            $groupBalance += $accountRow['balance'];
                            $j++;
                        ?>
                            <tr>
                                <th class="text-left account_data" colspan="1"><?= $accountRow['account_name'] ?><a href="?page=reports/list&acctId=<?php echo $accountRow['account_id']  ?>&from=<?php echo $from  ?>&to=<?php echo $to ?>"  class="nav-link text-light nav-user_list"></a></th>
                                <th class="text-left" colspan="1"><?= $accountRow['balance'] > 0 ? format_num($accountRow['balance']) : "" ?></th>
                                <th class="text-left" colspan="1"><?= $accountRow['balance'] < 0 ? format_num(abs($accountRow['balance'])) : "" ?></th>
                                <th class="text-left" colspan="1"></th>
                            </tr>
                        <?php endwhile; ?>
                        <th colspan="3" class="text-left">Balance</th>
                        <th class="text-left"><?= format_num($groupBalance) ?></th>
                    <?php endwhile; ?>

                    <?php
                    $sundarybalance = 0;
                    $sundarygroupByAccountByBalance = [];
                    $groupByAccount = $conn->query("select g.id AS group_id,
                    g.name AS group_name,
                    al.id AS account_id,
                    al.name AS account_name,
                    COALESCE(SUM(CASE WHEN ji.type = 1 THEN ji.amount ELSE 0 END), 0) AS total_debit,
                    COALESCE(SUM(CASE WHEN ji.type = 2 THEN ji.amount ELSE 0 END), 0) AS total_credit,
                    COALESCE(SUM(CASE WHEN ji.type = 1 THEN ji.amount ELSE -ji.amount END), 0) AS balance
                FROM
                    journal_items ji
                JOIN
                    group_list g ON ji.group_id  = g.id
                LEFT JOIN
                    account_list al  ON ji.account_id  = al.id
                WHERE ji.journal_id IN (SELECT id FROM journal_entries where user_id = '{$id}' and date(journal_date) BETWEEN '{$from}' and '{$to}' )
                and g.id IN (9,10)
                GROUP BY
                    g.id, al.id
                ORDER BY
                    g.id, al.id");
                    while ($arow = $groupByAccount->fetch_assoc()) {
                        $sundarygroupByAccountByBalance[$arow['group_name']][] = $arow;
                        $sundarybalance += $arow['balance'];
                    }
                    $sundarygroupNames = array_keys($sundarygroupByAccountByBalance);
                    $i = 0;

                    while (isset($sundarygroupNames[$i])) :
                        $sundarygroupName = $sundarygroupNames[$i];
                        $sundarygroupBalance = 0;
                        $sundaryAccounts = $sundarygroupByAccountByBalance[$sundarygroupName];
                        $j = 0;
                        while (isset($sundaryAccounts[$j])) {
                            $sundaryaccountRow = $sundaryAccounts[$j];
                            $sundarygroupBalance += $sundaryaccountRow['balance'];
                            $j++;
                        }
                        $i++;
                    ?>
                        <tr>
                            <th class="text-left" colspan="1"><?= $sundarygroupName ?></th>
                            <th class="text-left" colspan="1"><?= $sundarygroupBalance > 0 ? format_num($sundarygroupBalance) : "" ?></th>
                            <th class="text-left" colspan="1"><?= $sundarygroupBalance < 0 ? format_num(abs($sundarygroupBalance)) : "" ?></th>
                            <th class="text-left" colspan="1"></th>
                        </tr>
                        <th colspan="3" class="text-left">Balance</th>
                        <th class="text-left"><?= format_num($sundarygroupBalance) ?></th>
                    <?php endwhile; ?>
                </tbody>
                <tfoot>
                    <th colspan="3" class="text-center">Total</th>
                    <th class="text-left"><?= format_num($sundarybalance + $balance) ?></th>
                </tfoot>
            </table>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        $('#filter').submit(function(e) {
            e.preventDefault()
            location.href = "./?page=reports/working_trial_balance&" + $(this).serialize();
        })
        $('#print').click(function() {
            start_loader()
            var _h = $('head').clone();
            var _p = $('#outprint').clone();
            var el = $('<div>')
            _h.find('title').text('Working Trial Balance - Print View')
            _h.append('<style>html,body{ min-height: unset !important;}</style>')
            el.append(_h)
            el.append(_p)
            var nw = window.open("", "_blank", "width=900,height=700,top=50,left=250")
            nw.document.write(el.html())
            nw.document.close()
            setTimeout(() => {
                nw.print()
                setTimeout(() => {
                    nw.close()
                    end_loader()
                }, 200);
            }, 500);
        })

        $('.table td,.table th').addClass('py-1 px-2 align-middle')
    })
</script>