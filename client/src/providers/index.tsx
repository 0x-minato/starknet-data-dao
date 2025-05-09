"use client";

import { mainnet, sepolia } from "@starknet-react/chains";
import {
	type Connector,
	StarknetConfig,
	jsonRpcProvider,
} from "@starknet-react/core";
import type React from "react";
import { constants, type RpcProviderOptions } from "starknet";

import { getConnectors } from "~/components/navbar";
import { NETWORK } from "~/constants";
import { useIsMobile } from "~/hooks/useIsMobile";

interface ProvidersProps {
	children: React.ReactNode;
}

const chains = [mainnet, sepolia];

const provider = jsonRpcProvider({
	rpc: () => {
		const args: RpcProviderOptions = {
			nodeUrl: process.env.NEXT_PUBLIC_RPC_URL,
			chainId:
				NETWORK === constants.NetworkName.SN_MAIN
					? constants.StarknetChainId.SN_MAIN
					: constants.StarknetChainId.SN_SEPOLIA,
			blockIdentifier: "pending",
		};
		return args;
	},
});

const Providers: React.FC<ProvidersProps> = ({ children }) => {
	const isMobile = useIsMobile();

	if (typeof window === "undefined") return null;

	return (
		<StarknetConfig
			chains={chains}
			provider={provider}
			connectors={getConnectors(isMobile) as Connector[]}
		>
			{children}
		</StarknetConfig>
	);
};

export default Providers;
