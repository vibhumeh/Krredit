const token= artifacts.require("Zeno")
const loan=artifacts.require("Loaning")
const _nft=artifacts.require("Credit")

contract("token",()=>{
  it('Should give msg.sender freemoney 1',async()=>{
  let account1='0xEE4B24c7284b55A2AF915152984D1E0432b95b26';
  const adj=10**18;
  const zn= await token.deployed();
  const ln=await loan.deployed();
  console.log(ln.address);
  await zn.Initialise_Loaner(ln.address);
  console.log(zn.address);
  await ln.set(zn.address,account1);
  await ln.freemoney();
  const result= BigInt(await zn.balanceOf(account1));
  assert(result ==(1000*adj),result);
  })
  it('Should mint 10 tokens',async()=>{
  let account1='0xEE4B24c7284b55A2AF915152984D1E0432b95b26';
  const adj=10**18;
const zn= await token.deployed();
console.log(zn.address);
await zn.mint(account1,10)
const result= await zn.balanceOf(account1);
assert(result ===10*adj,"could not mint 10 tokieee");

  })
it('Should take loan successfully',async()=>{
  let account1='0xEE4B24c7284b55A2AF915152984D1E0432b95b26';
const adj=10**18;
const zn= await token.deployed();
const nft= await _nft.deployed();
const ln=await loan.deployed();
console.log(nft.address);
console.log(ln.address);
await zn.Initialise_Loaner(ln.address);
await nft.lendingcon(ln.address);
console.log(zn.address);
await ln.set(zn.address,nft.address);
await ln.freemoney();
await nft.safeMint(account1);
await nft.safeMint(account1);
const latestID=await nft.TokenIdCounterLatest();
await ln.setPrimary(latestID-1);
await ln.inc(account1);
await ln.takeloan(1);
const result=BigInt(await zn.balanceOf(account1));
assert(result==(adj*1000+110000000000000000000), "failed :(");


})

it("vouch test",async()=>{
  let account1='0xEE4B24c7284b55A2AF915152984D1E0432b95b26';
  const adj=10**18;
  const zn= await token.deployed();
  const nft= await _nft.deployed();
  const ln=await loan.deployed();
  console.log(nft.address);
  console.log(ln.address);
  await zn.Initialise_Loaner(ln.address);
  await nft.lendingcon(ln.address);
  console.log(zn.address);
  await ln.set(zn.address,nft.address);
  await ln.vouch(account1);



})
it('should set primary successfully',async()=>{
  let account1='0xEE4B24c7284b55A2AF915152984D1E0432b95b26';
  const adj=10**18;
const zn= await token.deployed();
const nft= await _nft.deployed();
const ln=await loan.deployed();
console.log(nft.address);
console.log(ln.address);
await zn.Initialise_Loaner(ln.address);
await nft.lendingcon(ln.address);
console.log(zn.address);
await ln.set(zn.address,nft.address);
await ln.freemoney();
await nft.safeMint(account1);
await nft.safeMint(account1);
const latestID=await nft.TokenIdCounterLatest();
await ln.setPrimary(2);
const result=await ln.Prime(account1);
assert(result==2,"failed");
})
})
