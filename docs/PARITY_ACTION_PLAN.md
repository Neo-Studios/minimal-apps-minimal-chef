# Platform Parity Action Plan

**Goal:** Achieve 90%+ feature parity across Web, iOS, and Android platforms  
**Current Status:** Web 69% | iOS 80% | Android 85%  
**Target Date:** TBD

---

## 🎯 Critical Gaps (Must Fix)

### Web Platform - Missing Core Features

#### 1. Recipe Edit/Delete ⚠️ HIGH PRIORITY
**Impact:** Users cannot modify or remove recipes  
**Effort:** Medium (2-3 hours)  
**Files to Create/Modify:**
- `web/src/app/recipes/[id]/edit/page.tsx` (new)
- `web/src/lib/firebase/recipes.ts` (already has updateRecipe/deleteRecipe)
- `web/src/app/recipes/[id]/page.tsx` (add edit/delete buttons)

**Implementation:**
```typescript
// Add to recipe detail page
<button onClick={() => router.push(`/recipes/${recipe.id}/edit`)}>
  Edit Recipe
</button>
<button onClick={handleDelete}>
  Delete Recipe
</button>

// Create edit page (copy from new recipe page)
// Pre-populate form with existing data
// Call updateRecipe() on submit
```

#### 2. Meal Planning Functionality ⚠️ HIGH PRIORITY
**Impact:** UI exists but doesn't work  
**Effort:** Medium (3-4 hours)  
**Files to Modify:**
- `web/src/app/meal-plan/page.tsx`
- `web/src/lib/firebase/mealPlans.ts` (create if missing)

**Implementation:**
```typescript
// Add meal to date
const addMeal = async (date: string, mealType: string, recipeId: string) => {
  await addDoc(collection(db, 'mealPlans'), {
    userId: user.uid,
    date,
    meals: { [mealType]: [recipeId] },
    createdAt: Timestamp.now()
  })
}

// Display meals from Firestore
// Add drag & drop (optional)
```

#### 3. Nutrition Tracking Functionality ⚠️ HIGH PRIORITY
**Impact:** UI exists but doesn't work  
**Effort:** Medium (3-4 hours)  
**Files to Modify:**
- `web/src/app/nutrition/page.tsx`
- Create nutrition tracking service

**Implementation:**
```typescript
// Track daily nutrition
// Calculate from recipes
// Display charts (use recharts or similar)
// Store in Firestore
```

#### 4. Recipe Rating UI ⚠️ MEDIUM PRIORITY
**Impact:** Cannot rate recipes  
**Effort:** Low (1-2 hours)  
**Files to Modify:**
- `web/src/app/recipes/[id]/page.tsx`
- `web/src/components/ui/StarRating.tsx` (new)

**Implementation:**
```typescript
// Star rating component
// Save to Firestore
// Display average rating
```

---

## ✅ Feature Parity Matrix

### Legend
- ✅ Implemented and working
- ⚠️ Partially implemented
- ❌ Not implemented
- 🔄 In progress

### Core Features

| Feature | Web | iOS | Android | Priority |
|---------|-----|-----|---------|----------|
| **Authentication** |
| Google Sign-In | ✅ | ✅ | ✅ | - |
| Sign Out | ✅ | ✅ | ✅ | - |
| **Recipe Management** |
| View Recipes | ✅ | ✅ | ✅ | - |
| Create Recipe | ✅ | ✅ | ✅ | - |
| Edit Recipe | ❌ | ✅ | ✅ | HIGH |
| Delete Recipe | ❌ | ✅ | ✅ | HIGH |
| Recipe Details | ✅ | ✅ | ✅ | - |
| Recipe Search | ✅ | ✅ | ✅ | - |
| Recipe Filtering | ✅ | ✅ | ✅ | - |
| Recipe Scaling | ✅ | ✅ | ✅ | - |
| Recipe Rating | ❌ | ✅ | ✅ | MEDIUM |
| Recipe Images | ✅ | ✅ | ✅ | - |
| **Cookbooks** |
| View Cookbooks | ✅ | ✅ | ✅ | - |
| Create Cookbook | ✅ | ✅ | ✅ | - |
| Edit Cookbook | ❌ | ✅ | ✅ | MEDIUM |
| Delete Cookbook | ✅ | ✅ | ✅ | - |
| Add Recipe | ✅ | ✅ | ✅ | - |
| Remove Recipe | ❌ | ✅ | ✅ | MEDIUM |
| **Meal Planning** |
| View Meal Plan | ✅ | ✅ | ✅ | - |
| Add Meal | ❌ | ✅ | ✅ | HIGH |
| Edit Meal | ❌ | ✅ | ✅ | HIGH |
| Delete Meal | ❌ | ✅ | ✅ | HIGH |
| **Shopping List** |
| View List | ✅ | ✅ | ✅ | - |
| Add Item | ✅ | ✅ | ✅ | - |
| Delete Item | ✅ | ✅ | ✅ | - |
| Check/Uncheck | ✅ | ✅ | ✅ | - |
| Auto-Categorize | ✅ | ❌ | ❌ | - |
| Group by Category | ✅ | ✅ | ✅ | - |
| **Nutrition** |
| View Dashboard | ✅ | ✅ | ✅ | - |
| Track Daily | ❌ | ✅ | ✅ | HIGH |
| Track Weekly | ❌ | ✅ | ✅ | MEDIUM |
| Track Monthly | ❌ | ✅ | ✅ | MEDIUM |
| **Timers** |
| Create Timer | ✅ | ✅ | ✅ | - |
| Start/Pause | ✅ | ✅ | ✅ | - |
| Delete Timer | ✅ | ✅ | ✅ | - |
| Notifications | ❌ | ✅ | ✅ | MEDIUM |
| **Settings** |
| Theme | ✅ | ✅ | ✅ | - |
| Font Size | ✅ | ✅ | ✅ | - |
| Language | ✅ | ✅ | ✅ | - |
| Accessibility | ✅ | ✅ | ✅ | - |

---

## 📋 Implementation Checklist

### Phase 1: Critical Features (Week 1)

- [ ] **Web: Recipe Edit**
  - [ ] Create edit page
  - [ ] Pre-populate form
  - [ ] Update Firestore
  - [ ] Test functionality

- [ ] **Web: Recipe Delete**
  - [ ] Add delete button
  - [ ] Confirmation dialog
  - [ ] Delete from Firestore
  - [ ] Redirect after delete

- [ ] **Web: Meal Planning**
  - [ ] Create mealPlans service
  - [ ] Add meal functionality
  - [ ] Edit meal functionality
  - [ ] Delete meal functionality
  - [ ] Display from Firestore

- [ ] **Web: Nutrition Tracking**
  - [ ] Create nutrition service
  - [ ] Track daily intake
  - [ ] Calculate from recipes
  - [ ] Display charts
  - [ ] Store in Firestore

### Phase 2: Important Features (Week 2)

- [ ] **Web: Recipe Rating**
  - [ ] Create StarRating component
  - [ ] Add to recipe detail
  - [ ] Save to Firestore
  - [ ] Display average

- [ ] **Web: Cookbook Edit**
  - [ ] Edit cookbook details
  - [ ] Update Firestore
  - [ ] Test functionality

- [ ] **Web: Remove Recipe from Cookbook**
  - [ ] Add remove button
  - [ ] Update cookbook
  - [ ] Refresh UI

- [ ] **Web: Timer Notifications**
  - [ ] Request permission
  - [ ] Show notification
  - [ ] Play sound

### Phase 3: Nice-to-Have (Week 3)

- [ ] **All: Unit Conversion**
  - [ ] Conversion logic
  - [ ] UI for conversion
  - [ ] User preference

- [ ] **All: Sort Options**
  - [ ] Sort by date
  - [ ] Sort by rating
  - [ ] Sort by name

- [ ] **Mobile: Auto-Categorization**
  - [ ] Port from Web
  - [ ] Test on mobile

- [ ] **Web: Instacart Integration**
  - [ ] API integration
  - [ ] Add to shopping list
  - [ ] Test flow

---

## 🔧 Technical Debt

### Web Platform

1. **Missing Edit/Delete Pages**
   - No edit page for recipes
   - No delete confirmation
   - No edit for cookbooks

2. **Non-Functional UIs**
   - Meal planning UI exists but doesn't work
   - Nutrition UI exists but doesn't work
   - Language selector doesn't change language

3. **Missing Services**
   - No mealPlans service
   - No nutrition tracking service
   - No notification service

### iOS Platform

1. **Auto-Categorization**
   - Shopping list doesn't auto-categorize
   - Manual category selection only

### Android Platform

1. **Auto-Categorization**
   - Shopping list doesn't auto-categorize
   - Manual category selection only

---

## 📊 Progress Tracking

### Web Platform Progress

**Current:** 69% (45/65 features)  
**Target:** 90% (59/65 features)  
**Gap:** 14 features

**Priority Breakdown:**
- High Priority: 7 features
- Medium Priority: 5 features
- Low Priority: 2 features

**Estimated Time:**
- High Priority: 12-15 hours
- Medium Priority: 8-10 hours
- Low Priority: 3-4 hours
- **Total:** 23-29 hours (~3-4 days)

### iOS Platform Progress

**Current:** 80% (52/65 features)  
**Target:** 90% (59/65 features)  
**Gap:** 7 features

**Estimated Time:** 8-10 hours

### Android Platform Progress

**Current:** 85% (55/65 features)  
**Target:** 90% (59/65 features)  
**Gap:** 5 features

**Estimated Time:** 5-7 hours

---

## 🎯 Success Criteria

### Definition of Done

A feature is considered "done" when:
1. ✅ Implemented on all 3 platforms
2. ✅ Tested manually
3. ✅ Data persists to Firestore
4. ✅ UI is responsive
5. ✅ Error handling in place
6. ✅ Loading states implemented
7. ✅ Accessibility considered

### Parity Achieved When

- All platforms at 90%+ completion
- All HIGH priority features implemented
- All MEDIUM priority features implemented
- Core user flows work on all platforms
- No critical bugs

---

## 📝 Notes

### Exclusions (As Requested)

Not included in parity check:
- AI features (recipe generation, photo analysis)
- Design systems (Material 3, Liquid Glass)
- Platform-specific features (HealthKit, Health Connect)
- Animation styles
- Component libraries

### Platform-Specific Features (Allowed)

These are OK to be different:
- HealthKit integration (iOS only)
- Health Connect (Android only)
- Platform-specific UI patterns
- Native notifications
- Platform-specific optimizations

---

**Last Updated:** 2024-11-14  
**Next Review:** After Phase 1 completion
