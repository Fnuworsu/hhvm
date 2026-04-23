use namespace Vault;

<<__EntryPoint>>
function main(): void {
  $my_bal = 1000;
  
  // 1. Use the 'using' statement for the session
  using ($session = new Vault\VaultSession()) {
    echo "Current Balance: $my_bal\n";
    
    // 2. Use 'inout' to update the balance through the session
    $session->applyInterest(inout $my_bal);
    
    echo "New Balance after Interest: $my_bal\n";
  } 
  // 3. Ensure your console shows the "Connection Closed" message here!
}