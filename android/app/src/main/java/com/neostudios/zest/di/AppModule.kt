package com.neostudios.zest.di

import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.storage.FirebaseStorage
import com.neostudios.zest.data.repository.AuthRepositoryImpl
import com.neostudios.zest.data.repository.CollaborativeMealPlanRepositoryImpl
import com.neostudios.zest.data.repository.ImageStorageRepositoryImpl
import com.neostudios.zest.data.repository.MealKitRepositoryImpl
import com.neostudios.zest.data.repository.UserProfileRepositoryImpl // Import UserProfileRepositoryImpl
import com.neostudios.zest.domain.repository.AuthRepository
import com.neostudios.zest.domain.repository.CollaborativeMealPlanRepository
import com.neostudios.zest.domain.repository.ImageStorageRepository
import com.neostudios.zest.domain.repository.MealKitRepository
import com.neostudios.zest.domain.repository.UserProfileRepository // Import UserProfileRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object AppModule {
    
    @Provides
    @Singleton
    fun provideFirebaseAuth(): FirebaseAuth = FirebaseAuth.getInstance()
    
    @Provides
    @Singleton
    fun provideFirestore(): FirebaseFirestore = FirebaseFirestore.getInstance()
    
    @Provides
    @Singleton
    fun provideFirebaseStorage(): FirebaseStorage = FirebaseStorage.getInstance()

    @Provides
    @Singleton
    fun provideAuthRepository(authRepositoryImpl: AuthRepositoryImpl): AuthRepository = authRepositoryImpl

    @Provides
    @Singleton
    fun provideImageStorageRepository(imageStorageRepositoryImpl: ImageStorageRepositoryImpl): ImageStorageRepository = imageStorageRepositoryImpl

    @Provides
    @Singleton
    fun provideMealKitRepository(mealKitRepositoryImpl: MealKitRepositoryImpl): MealKitRepository = mealKitRepositoryImpl

    @Provides
    @Singleton
    fun provideCollaborativeMealPlanRepository(collaborativeMealPlanRepositoryImpl: CollaborativeMealPlanRepositoryImpl): CollaborativeMealPlanRepository = collaborativeMealPlanRepositoryImpl

    @Provides
    @Singleton
    fun provideUserProfileRepository(userProfileRepositoryImpl: UserProfileRepositoryImpl): UserProfileRepository = userProfileRepositoryImpl
}
