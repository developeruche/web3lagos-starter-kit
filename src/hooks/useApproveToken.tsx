// import {
//   useReadContract,
//   useSimulateContract,
//   useWriteContract,
//   useWaitForTransactionReceipt,
// } from "wagmi";
// import { hexToDecimal } from "../constants/helpers";
// import { parseEther } from "viem";
// import ERC20TOKENABI from "../constants/abi/erc20.abi.json";

// interface approveParamsTypes {
//   user?: string;
//   functionName?: string;
//   contractArgs?: Array<any>;
//   price?: bigint | undefined;
//   ApproveCA?: `0x${string}`;
// }

// //[x] - ApproveCA - you can change this to your own contract Address

// export const useApproveToken = ({
//   price,
//   ApproveCA,
//   contractArgs,
//   functionName,
//   user,
// }: approveParamsTypes) => {
//   const { data } = useSimulateContract({
//     address: ApproveCA,
//     abi: ERC20TOKENABI,
//     functionName: "approve",
//     args: [ApproveCA!, price ? parseEther(price.toString()) : "0"], // Convert to string if not undefined
//   });

//   const {
//     data: writeData,
//     isPending: approveTokenLoading,
//     writeContract,
//   } = useWriteContract();

//   writeContract(data!.request);

//   const {
//     isError: approveError,
//     isSuccess: approveSuccess,
//     isLoading: approveLoading,
//   } = useWaitForTransactionReceipt({
//     hash: writeData,
//   });

//   const { data: contractDataConfig } = useSimulateContract({
//     address: ApproveCA,
//     //web3AbujaethABI
//     abi: ERC20TOKENABI,
//     functionName,
//     args: contractArgs,
//   });

//   const {
//     data: contractData,
//     isPending: writeLoading,
//     writeContract: write,
//   } = useWriteContract();

//   //example how to use is on Button in React
//   // <button disabled={isPending} type="submit">
//   //   Mint
//   //   {isPending ? "Confirming..." : "Mint"}
//   // </button>;

//   write(contractDataConfig!.request);

//   const {
//     isError: waitError,
//     isSuccess: waitSuccess,
//     isLoading: waitLoading,
//   } = useWaitForTransactionReceipt({
//     hash: contractData,
//   });

//   const { data: tokenRead } = useReadContract({
//     address: ApproveCA,
//     abi: ERC20TOKENABI,
//     functionName: "allowance",
//     args: [user, ApproveCA],
//   });

//   const tokenAuthorization = () => {
//     const priceInput = price !== undefined ? parseEther(price.toString()) : "0";

//     //@ts-ignore
//     if (hexToDecimal(tokenRead?._hex) > hexToDecimal(priceInput?._hex)) {
//       write(contractDataConfig!.request);
//     } else {
//       writeContract(data!.request);
//     }
//   };

//   return {
//     approveTokenLoading,
//     approveError,
//     approveSuccess,
//     approveLoading,
//     tokenAuthorization,
//     writeLoading,
//     waitError,
//     waitSuccess,
//     waitLoading,
//   };
// };
