export interface CollaborativeMealPlan {
  id: string;
  name: string;
  ownerId: string;
  members: CollaborativeMealPlanMember[];
  mealPlanIds: string[]; // References to individual meal plans
  createdAt: number;
  updatedAt: number;
}

export interface CollaborativeMealPlanMember {
  userId: string;
  role: 'owner' | 'editor' | 'viewer';
}
