package com.neostudios.zest.domain.repository

import com.google.firebase.auth.FirebaseUser
import kotlinx.coroutines.flow.Flow

interface AuthRepository {
    val currentUser: Flow<FirebaseUser?>

    suspend fun signInWithGoogle(idToken: String): FirebaseUser?
    suspend fun signOut()
}
