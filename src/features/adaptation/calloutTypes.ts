export const CALLOUT_TYPES = ['tip', 'warning', 'beginner'] as const
export type CalloutType = (typeof CALLOUT_TYPES)[number]

export function isCalloutType(type: string | undefined): type is CalloutType {
  return CALLOUT_TYPES.includes(type as CalloutType)
}
