//SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

interface IERC20 {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}

library StringUtils {
    /// @dev Does a byte-by-byte lexicographical comparison of two strings.
    /// @return a negative number if `_a` is smaller, zero if they are equal
    /// and a positive numbe if `_b` is smaller.
    function compare(string memory _a, string memory _b)
        public
        pure
        returns (int256)
    {
        bytes memory a = bytes(_a);
        bytes memory b = bytes(_b);
        uint256 minLength = a.length;
        if (b.length < minLength) minLength = b.length;
        //@todo unroll the loop into increments of 32 and do full 32 byte comparisons
        for (uint256 i = 0; i < minLength; i++)
            if (a[i] < b[i]) return -1;
            else if (a[i] > b[i]) return 1;
        if (a.length < b.length) return -1;
        else if (a.length > b.length) return 1;
        else return 0;
    }

    /// @dev Compares two strings and returns true iff they are equal.
    function equal(string memory _a, string memory _b)
        public
        pure
        returns (bool)
    {
        return compare(_a, _b) == 0;
    }

    /// @dev Finds the index of the first occurrence of _needle in _haystack
    function indexOf(string memory _haystack, string memory _needle)
        public
        pure
        returns (int256)
    {
        bytes memory h = bytes(_haystack);
        bytes memory n = bytes(_needle);
        if (h.length < 1 || n.length < 1 || (n.length > h.length)) return -1;
        else if (h.length > (2**128 - 1))
            // since we have to be able to return -1 (if the char isn't found or input error), this function must return an "int" type with a max length of (2^128 - 1)
            return -1;
        else {
            uint256 subindex = 0;
            for (uint256 i = 0; i < h.length; i++) {
                if (h[i] == n[0]) // found the first char of b
                {
                    subindex = 1;
                    while (
                        subindex < n.length &&
                        (i + subindex) < h.length &&
                        h[i + subindex] == n[subindex] // search until the chars don't match or until we reach the end of a or b
                    ) {
                        subindex++;
                    }
                    if (subindex == n.length) return int256(i);
                }
            }
            return -1;
        }
    }
}

contract ArbitrageBot {
    address private uniContractAddress =
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private sushiContractAddress =
        0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506;

    IUniswapV2Router02 public uniswapRouter =
        IUniswapV2Router02(uniContractAddress);
    IUniswapV2Router02 public sushiswapRouter =
        IUniswapV2Router02(sushiContractAddress);

    mapping(string => bool) public exchanges;

    function getUniContractAddress() public view returns (address) {
        return uniContractAddress;
    }

    function getSushiContractAddress() public view returns (address) {
        return sushiContractAddress;
    }

    function setUniContractAddress(address addr) public {
        uniContractAddress = addr;
        uniswapRouter = IUniswapV2Router02(uniContractAddress);
        exchanges["UNISWAP"] = true;
    }

    function setSushiContractAddress(address addr) public {
        sushiContractAddress = addr;
        sushiswapRouter = IUniswapV2Router02(sushiContractAddress);
        exchanges["SUSHISWAP"] = true;
    }

    function inspectSender() public view returns (address) {
        return msg.sender;
    }

    function inspectOrigin() public view returns (address) {
        return tx.origin;
    }

    struct SwapParams {
        address fromToken;
        address toToken;
        uint256 amountIn;
        uint256 amountOutMin;
        string exng;
        string fromSym;
    }

    struct PathParams {
        address fromToken;
        address toToken;
    }

    function executeSwap(
        address fromToken,
        address toToken,
        string memory fromSym,
        string memory toSym,
        string memory fromExng,
        string memory toExng,
        uint256 amountToSwap,
        uint256 amountOut,
        uint256 slippage
    ) public payable returns (uint256) {
        // require(
        //     exchanges[fromExng],
        //     string(abi.encodePacked(fromExng, " Exchange not supported"))
        // );
        // require(
        //     exchanges[toExng],
        //     string(abi.encodePacked(toExng, " Exchange not supported"))
        // );

        uint256 amountIn = amountToSwap;
        uint256 amountOutMin = amountOut;

        SwapParams memory swapParams1;
        swapParams1.fromToken = fromToken;
        swapParams1.toToken = toToken;
        swapParams1.amountIn = amountIn;
        swapParams1.amountOutMin = amountOutMin;
        swapParams1.exng = fromExng;
        swapParams1.fromSym = fromSym;

        SwapParams memory swapParams2;
        swapParams2.fromToken = toToken;
        swapParams2.toToken = fromToken;
        swapParams2.amountOutMin = amountIn;
        swapParams2.exng = toExng;
        swapParams2.fromSym = toSym;

        /*

        // /////////////////////////////// STRAIGTH EXECUTION ///////////////////////////
        PathParams memory pathParams1;
        pathParams1.fromToken = fromToken;
        pathParams1.toToken = toToken;
        
        PathParams memory pathParams2;
        pathParams2.fromToken = toToken;
        pathParams2.toToken = fromToken;
        
        // Swap process 1
        require(
            IERC20(fromToken).transferFrom(msg.sender, address(this), amountIn),
            string(
                abi.encodePacked(fromSym, " Token transfer to contract failed!")
            )
        );
        uint256[] memory FromExngAmountOuts;
        // Exchange contracts dynamic condition
        if (StringUtils.equal(fromExng, "UNISWAP")) {
            require(
                IERC20(fromToken).approve(uniContractAddress, amountIn),
                string(
                    abi.encodePacked(
                        fromExng,
                        " contract approval to withdraw the ",
                        fromSym,
                        " token is failed!"
                    )
                )
            );
            FromExngAmountOuts = uniswapRouter.swapExactTokensForTokens(
                amountIn,
                amountOutMin,
                _getPathForTokens(pathParams1),
                msg.sender,
                block.timestamp
            );
        } else if (StringUtils.equal(fromExng, "SUSHISWAP")) {
            require(
                IERC20(fromToken).approve(sushiContractAddress, amountIn),
                string(
                    abi.encodePacked(
                        fromExng,
                        " contract approval to withdraw the ",
                        fromSym,
                        " token is failed!"
                    )
                )
            );
            FromExngAmountOuts = sushiswapRouter.swapExactTokensForTokens(
                amountIn,
                amountOutMin,
                _getPathForTokens(pathParams1),
                msg.sender,
                block.timestamp
            );
        } else {
            revert("Exchange not supported");
        }

        // Swap process 2
        require(
            IERC20(toToken).transferFrom(
                msg.sender,
                address(this),
                FromExngAmountOuts[1]
            ),
            string(
                abi.encodePacked(toSym, " Token transfer to contract failed!")
            )
        );
        uint256[] memory toExngAmountOuts;
        if (StringUtils.equal(fromExng, "UNISWAP")) {
            require(
                IERC20(toToken).approve(
                    uniContractAddress,
                    FromExngAmountOuts[1]
                ),
                string(
                    abi.encodePacked(
                        toExng,
                        " contract approval to withdraw the ",
                        toSym,
                        " token is failed!"
                    )
                )
            );
            toExngAmountOuts = uniswapRouter.swapExactTokensForTokens(
                FromExngAmountOuts[1],
                amountIn,
                _getPathForTokens(pathParams2),
                msg.sender,
                block.timestamp
            );
        } else if (StringUtils.equal(fromExng, "SUSHISWAP")) {
            require(
                IERC20(toToken).approve(
                    sushiContractAddress,
                    FromExngAmountOuts[1]
                ),
                string(
                    abi.encodePacked(
                        toExng,
                        " contract approval to withdraw the ",
                        toSym,
                        " token is failed!"
                    )
                )
            );
            toExngAmountOuts = sushiswapRouter.swapExactTokensForTokens(
                FromExngAmountOuts[1],
                amountIn,
                _getPathForTokens(pathParams2),
                msg.sender,
                block.timestamp
            );
        } else {
            revert("Exchange not supported");
        }
        */

        // /////////////////////////////// FUNCTION CALL EXECUTION ///////////////////////////
        // Swap process 1
        uint256[2] memory FromExngAmountOuts = _swap(swapParams1);
        swapParams2.amountIn = FromExngAmountOuts[1];

        // Swap process 2
        uint256[2] memory toExngAmountOuts = _swap(swapParams2);

        // refund leftover amount to user
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "refund failed");

        return toExngAmountOuts[1];
        return toExngAmountOuts[1] - amountIn;
    }

    function _getPathForTokens(PathParams memory pathParams)
        private
        pure
        returns (address[] memory)
    {
        address[] memory path = new address[](2);
        path[0] = pathParams.fromToken;
        path[1] = pathParams.toToken;

        return path;
    }

    function _swap(SwapParams memory swapParams)
        public
        payable
        returns (uint256[2] memory)
    {
        // Exchange contracts dynamic condition
        if (StringUtils.equal(swapParams.exng, "UNISWAP")) {
            bool swapTokenBool = IERC20(swapParams.fromToken).transferFrom(
                msg.sender,
                address(this),
                swapParams.amountIn
            );

            require(
                swapTokenBool,
                string(
                    abi.encodePacked(
                        swapParams.fromSym,
                        " Token transfer to contract failed!"
                    )
                )
            );

            PathParams memory pathParams;
            pathParams.fromToken = swapParams.fromToken;
            pathParams.toToken = swapParams.toToken;
            require(
                IERC20(swapParams.fromToken).approve(
                    uniContractAddress,
                    swapParams.amountIn
                ),
                string(
                    abi.encodePacked(
                        swapParams.exng,
                        " contract approval to withdraw the ",
                        swapParams.fromSym,
                        " token is failed!"
                    )
                )
            );
            uint256[] memory swapRes = uniswapRouter.swapExactTokensForTokens(
                swapParams.amountIn,
                swapParams.amountOutMin,
                _getPathForTokens(pathParams),
                address(this),
                block.timestamp
            );
            return [swapRes[0], swapRes[1]];
        } else if (StringUtils.equal(swapParams.exng, "SUSHISWAP")) {
            PathParams memory pathParams;
            pathParams.fromToken = swapParams.toToken;
            pathParams.toToken = swapParams.fromToken;
            require(
                IERC20(swapParams.fromToken).approve(
                    sushiContractAddress,
                    swapParams.amountIn
                ),
                string(
                    abi.encodePacked(
                        swapParams.exng,
                        " contract approval to withdraw the ",
                        swapParams.fromSym,
                        " token is failed!"
                    )
                )
            );

            return [uint256(155), uint256(155)];
            // return
            sushiswapRouter.swapExactTokensForTokens(
                swapParams.amountIn,
                swapParams.amountOutMin,
                _getPathForTokens(pathParams),
                msg.sender,
                block.timestamp
            );
        } else {
            revert("Exchange not supported");
        }
    }

    // important to receive ETH
    receive() external payable {}
}
