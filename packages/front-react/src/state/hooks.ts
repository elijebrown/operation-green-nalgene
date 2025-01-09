import { useStore } from './store'

export const useView = () => useStore((state) => state.view)
export const useStoreActions = () => useStore((state) => state.storeActions)
