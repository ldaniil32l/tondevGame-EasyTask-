pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'myGameInterface.sol';

contract myGameMilitaryUnit is myGameInterface {

    struct gameObj {
        uint health;
        uint hit;
        uint defence;
    }

    gameObj public militaryUnit;
    address public enemy;


    modifier checkAccept{
		tvm.accept();
		_;
	}

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    function getAttack(uint valueDamage) external override checkAccept {
        valueDamage = valueDamage - militaryUnit.defence;
        militaryUnit.health = militaryUnit.health - valueDamage;
        enemy = msg.sender;
        if (militaryUnit.health <= 0){
            selfDestroy(enemy);
        }
    }

    function getEnemyAddress() public view checkAccept returns(address) {
        return enemy;
    }

    function getHit () virtual internal checkAccept view returns(uint) {
        return militaryUnit.hit;
    }

    function getDefence () virtual internal checkAccept view returns(uint) {
        return militaryUnit.defence;
    }

    function getHealth () virtual internal checkAccept view returns(uint) {
        return militaryUnit.health;
    }

    function isDestroy() private checkAccept{
        if (militaryUnit.health <= 0){
            selfDestroy(enemy);
        }
    }

    function selfDestroy(address dest) private checkAccept {
        uint16 flag = 128 + 32;
        dest.transfer(0, false, flag);
    }

}