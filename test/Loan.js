const token= artifacts.require("Zeno")
const loan=artifacts.require("Loaning")
const nft=artifacts.require("Credit")

contract("token",()=>{
  it('Should give msg.sender freemoney 1',async()=>{
    let account1='0x2eDA38Cb880B471821f3938eA8EAd9D6c6BfC5f0';
  const adj=10**18;
  const zn= await token.deployed();
  const ln=await loan.deployed();
  console.log(ln.address);
  await zn.giveRole(ln.address);
  console.log(zn.address);
  await ln.set(zn.address,account1);
  await ln.freemoney();
  const result= BigInt(await zn.balanceOf(account1));
  assert(result ==(1000*adj),"rip no workie");
  })
  it('Should mint 10 tokens',async()=>{
    let account1='0x2eDA38Cb880B471821f3938eA8EAd9D6c6BfC5f0';
  const adj=10**18;
const zn= await token.deployed();
console.log(zn.address);
await zn.mint(account1,10*adj)
const result=BigInt(await zn.balanceOf(account1));
assert(result==10*adj,"is this working?");

  })


})
