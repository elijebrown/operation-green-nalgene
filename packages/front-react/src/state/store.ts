import { create } from 'zustand'
import { memoriesType, tripsType } from '../types-constants/types'

type viewType = 'carousel' | 'quad' | 'compact' | 'library'
type imageQuality = 'best' | 'high' | 'low'
type storeState = {
    view: viewType
    quality: imageQuality
    tripsData: tripsType[]
    memoriesData: memoriesType[]
}

type storeAction = {
    storeActions: {
        setView: (view: viewType) => void
    }
}

type storeType = storeState & storeAction

export const useStore = create<storeType>()((set, get) => ({
    view: 'carousel',
    quality: 'high',
    tripsData: [],
    memoriesData: [],
    storeActions: {
        setView: (view) => set({ view }),
    },
}))

// const useStore = create((set) => ({
//   bears: 0,
//   increasePopulation: () => set((state) => ({ bears: state.bears + 1 })),
//   removeAllBears: () => set({ bears: 0 }),
//   updateBears: (newBears) => set({ bears: newBears }),
// }))
