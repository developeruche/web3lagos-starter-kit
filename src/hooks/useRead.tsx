import { useReadContract } from "wagmi";
import { addCA } from "./useAdd";

//[x] - import your addABI or just export as const here
export const addABI: any = [];

//[x] - you can change the name of the props here
export interface readProps {
  functionName: string;
  args?: Array<any>;
}

//-[x] - you can change the name of custom hook function name
const useRead = ({ functionName, args }: readProps) => {
  const data = useReadContract({
    address: addCA,
    abi: addABI,
    functionName,
    args,
  });

  return data || [];
};

export default useRead;
