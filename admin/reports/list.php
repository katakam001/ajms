
<?php 
if(isset($_GET['acctId']) ){
 $acctId = $_GET['acctId'];
}
if(isset($_GET['from']) ){
  $from = $_GET['from'];
}
if(isset($_GET['to']) ){
 $to= $_GET['to'];
}
function format_num($number){
	$decimals = 0;
	$num_ex = explode('.',$number);
	$decimals = isset($num_ex[1]) ? strlen($num_ex[1]) : 0 ;
	return number_format($number,2);
}
?>

<div class="card card-outline card-primary">
	<div class="card-header">
		<h3 class="card-title">Journal Entries</h3>
	</div>
	<div class="card-body">
        <div class="container-fluid">
			<table class="table table-hover table-striped table-bordered">
				<colgroup>
					<col width="15%">
					<col width="15%">
					<col width="45%">
					<col width="15%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>Date</th>
						<th>Journal Code</th>
						<th class="p-0">
							<div class="d-flex w-100">
								<div class="col-6 border">Description</div>
								<div class="col-3 border">Debit</div>
								<div class="col-3 border">Credit</div>
							</div>
						</th>
						<th>Encoded By</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<?php 
					$debitTotal=0;
					$creditTotal=0;
					$total=0;
					$swhere = "";
					if($_settings->userdata('type') != 1){
						$swhere = " where user_id = '{$_settings->userdata('id')}' and date(journal_date) BETWEEN '{$from}' and '{$to} ";
					}
					$users = $conn->query("SELECT id,username FROM `users` where id in (SELECT `user_id` FROM `journal_entries` {$swhere})");
					$user_arr = array_column($users->fetch_all(MYSQLI_ASSOC),'username','id');
					$swhere = " where user_id = '{$_settings->userdata('id')}' and date(journal_date) BETWEEN '{$from}' and '{$to}' and id in (select journal_id from journal_items where account_id = '$acctId')";
					$journals = $conn->query("SELECT * FROM `journal_entries` {$swhere} ");
					while($row = $journals->fetch_assoc()):
					?>
					<tr>
						<td class="text-center"><?= date("M d, Y", strtotime($row['journal_date'])) ?></td>
						<td class=""><?= $row['code'] ?></td>
						<td class="p-0">
							<div class="d-flex w-100">
								<div class="col-6 border"><?= $row['description'] ?></div>
								<div class="col-3 border"></div>
								<div class="col-3 border"></div>
							</div>
							<?php 
							$jitems = $conn->query("SELECT j.*,a.name as account FROM `journal_items` j inner join account_list a on j.account_id = a.id inner join group_list g on j.group_id = g.id where j.journal_id = '{$row['id']}'");                            
							while($rowss = $jitems->fetch_assoc()):
								if($rowss['account_id'] == $acctId){
								if( $rowss['type'] == 1){
									$debitTotal+=$rowss['amount'];
									// echo $rowss['amount'];
								}else{
									$creditTotal+=$rowss['amount'];  
								}
							}
							?>
							<div class="d-flex w-100">
								<div class="col-6 border"><span class="pl-4"><?= $rowss['account'] ?></span></div>
								<div class="col-3 border text-right"><?= $rowss['type'] == 1 ? format_num($rowss['amount']) : '' ?></div>
								<div class="col-3 border text-right"><?= $rowss['type'] == 2 ? format_num($rowss['amount']) : '' ?></div>
							</div>
							<?php endwhile; ?>
						</td>
						<td><?= isset($user_arr[$row['user_id']]) ? $user_arr[$row['user_id']] : "N/A" ?></td>
						<td class="text-center">
							<button type="button" class="btn btn-flat btn-default btn-sm dropdown-toggle dropdown-icon" data-toggle="dropdown">
									Action
								<span class="sr-only">Toggle Dropdown</span>
							</button>
							<div class="dropdown-menu" role="menu">
								<a class="dropdown-item edit_data" href="javascript:void(0)" data-id ="<?php echo $row['id'] ?>"><span class="fa fa-edit text-primary"></span> Edit</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item delete_data" href="javascript:void(0)" data-id="<?php echo $row['id'] ?>"  data-code="<?php echo $row['code'] ?>"><span class="fa fa-trash text-danger"></span> Delete</a>
							</div>
						</td>
					</tr>
					<?php endwhile; ?>
				</tbody>
				<tfoot>
                    <!-- <th class="col-6 border"><span class="pl-4"></span></th> -->
                    <th colspan="2" class="text-right"></th>
					<th colspan="1" class="text-right"><?= format_num($debitTotal)."                          ".format_num($creditTotal) ?></th>
                    <th colspan="1" class="text-left"><?= format_num($debitTotal - $creditTotal) ?></th>
                </tfoot>
			</table>
		</div>
		<div class="card-footer">
			<div class="col-md-12">
				<div class="row">
					<a class="btn btn-sm btn-secondary" href="./?page=reports/working_trial_balance">Back</a>
				</div>
			</div>
		</div>		
	</div>
</div>
