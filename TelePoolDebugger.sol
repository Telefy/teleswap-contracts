// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;


contract TelePoolDebugger {

	uint256 private _totalBalanceTemp; // temporary balance to calculate reward per block
	uint256 public startBlock; // start block of the stake pool
	uint256 public totalBoostDebt; // start block of the stake pool
	uint256 private _lastRewardBlock; // update bblock after

	uint256 public constant MIN_TELE_PER_BLOCK = 1e18; // 1 TELE
	uint256 public TELE_PER_BLOCK = 10e18; // 10 TELE


	/**
	 * @notice Set TELE_PER_BLOCK
	 * @dev Only callable by the contract admin.
	 */
	function setTelePerBlock(uint256 _telePerBlock) external onlyAdmin {
		require(
			_telePerBlock < MIN_TELE_PER_BLOCK,
			"TELE_PER_BLOCK should not be lesser than minimum TELE limit"
		);
		TELE_PER_BLOCK = _telePerBlock;
		emit NewTelePerBlock(_telePerBlock);
	}


	/**
	 * @notice Calculates the total underlying tokens
	 * @dev It includes tokens held by the contract and the boost debt amount.
	 */
	function balanceOf() public view returns (uint256) {
		return
			(block.number <= _lastRewardBlock)
				? (_totalBalanceTemp + totalBoostDebt)
				: ((block.number - _lastRewardBlock) * TELE_PER_BLOCK) +
					_totalBalanceTemp +
					totalBoostDebt;
	}

	function updateRewardAndGetBalance() public returns (uint256) {
		if (block.number > _lastRewardBlock) {
			_totalBalanceTemp += ((block.number - _lastRewardBlock) * TELE_PER_BLOCK);
			_lastRewardBlock = block.number;
		}
		return _totalBalanceTemp + totalBoostDebt;
	}
}
