import { create } from 'zustand'

type viewType = 'carousel' | 'quad' | 'compact' | 'library'
type imageQuality = 'best' | 'high' | 'low'
type storeState = {
    view: viewType
    quality: imageQuality
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
