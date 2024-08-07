import {
  useSimulateContract,
  useWriteContract,
  useWaitForTransactionReceipt,
} from "wagmi";

//[x] - import your addABI or just export as const here
export const addABI: any = [];

//[x] - you can change the name of the props here
export interface addProps {
  functionName: string;
  args?: Array<any>;
  value?: bigint;
}

//[x] - you can put your contract here
export const addCA = "0x";

//-[x] - you can change the name of custom hook function name
const useAdd = ({ functionName, args, value }: addProps) => {
  const { data } = useSimulateContract({
    address: addCA,
    abi: addABI,
    functionName,
    args,
    value,
  });

  //[x] - you can change the name to your choice
  const {
    data: addData,
    isPending: addLoading,
    writeContract: addWrite,
  } = useWriteContract();

  addWrite(data!.request);

  //[x] - example how to use is on Button in React
  // <button disabled={isPending} type="submit">
  //   Mint
  //   {isPending ? "Confirming..." : "Mint"}
  // </button>;

  const {
    isError: addWaitError,
    isSuccess: addWaitSuccess,
    isLoading: addWaitLoading,
  } = useWaitForTransactionReceipt({
    hash: addData,
  });

  return {
    addLoading,
    addWrite,
    addWaitError,
    addWaitSuccess,
    addWaitLoading,
  };
};

export default useAdd;
