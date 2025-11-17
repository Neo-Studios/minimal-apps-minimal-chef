package com.neostudios.zest.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import com.google.firebase.auth.FirebaseAuth
import com.neostudios.zest.domain.model.CollaborativeMealPlanMember
import com.neostudios.zest.ui.navigation.Screen
import javax.inject.Inject

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CollaborativeMealPlanDetailScreen(
    planId: String,
    navController: NavController,
    viewModel: CollaborativeMealPlanViewModel = hiltViewModel(),
    auth: FirebaseAuth = FirebaseAuth.getInstance() // Inject FirebaseAuth directly
) {
    val uiState by viewModel.uiState.collectAsState()

    var newMemberEmail by remember { mutableStateOf("") }
    var mealPlanToAddId by remember { mutableStateOf("") }

    LaunchedEffect(planId) {
        viewModel.loadCollaborativeMealPlanDetail(planId)
    }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(uiState.selectedCollaborativeMealPlan?.name ?: "Plan Details") },
                navigationIcon = {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(Icons.Default.ArrowBack, contentDescription = "Back")
                    }
                }
            )
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .padding(16.dp)
        ) {
            if (uiState.isLoading) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    CircularProgressIndicator()
                }
            } else if (uiState.error != null) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text("Error: ${uiState.error}", color = MaterialTheme.colorScheme.error)
                }
            } else if (uiState.selectedCollaborativeMealPlan == null) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text("Collaborative meal plan not found.", style = MaterialTheme.typography.headlineSmall)
                }
            } else {
                val plan = uiState.selectedCollaborativeMealPlan
                val isOwner = plan.ownerId == auth.currentUser?.uid // Use injected FirebaseAuth

                LazyColumn(modifier = Modifier.fillMaxSize()) {
                    item {
                        Text("Owner: ${plan.ownerId}", style = MaterialTheme.typography.bodyLarge)
                        Spacer(modifier = Modifier.height(16.dp))

                        Text("Members:", style = MaterialTheme.typography.titleLarge)
                        Spacer(modifier = Modifier.height(8.dp))
                    }
                    items(plan.members) { member ->
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text("${member.userId} (${member.role})", style = MaterialTheme.typography.bodyMedium)
                            if (isOwner && member.userId != auth.currentUser?.uid) {
                                IconButton(onClick = { viewModel.removeMemberFromCollaborativeMealPlan(plan.id, member) }) {
                                    Icon(Icons.Default.Delete, contentDescription = "Remove Member")
                                }
                            }
                        }
                    }
                    item {
                        if (isOwner) {
                            Spacer(modifier = Modifier.height(16.dp))
                            OutlinedTextField(
                                value = newMemberEmail,
                                onValueChange = { newMemberEmail = it },
                                label = { Text("New Member Email") },
                                modifier = Modifier.fillMaxWidth()
                            )
                            Spacer(modifier = Modifier.height(8.dp))
                            Button(
                                onClick = {
                                    // In a real app, resolve email to userId
                                    val dummyUserId = newMemberEmail.trim().toLowerCase().replace("[^a-z0-9]".toRegex(), "") + "-id"
                                    val newMember = CollaborativeMealPlanMember(userId = dummyUserId, role = "viewer")
                                    viewModel.addMemberToCollaborativeMealPlan(plan.id, newMember)
                                    newMemberEmail = ""
                                },
                                modifier = Modifier.fillMaxWidth(),
                                enabled = newMemberEmail.isNotBlank()
                            ) {
                                Text("Add Member")
                            }
                        }
                        Spacer(modifier = Modifier.height(16.dp))
                        Text("Linked Meal Plans:", style = MaterialTheme.typography.titleLarge)
                        Spacer(modifier = Modifier.height(8.dp))
                    }
                    items(plan.mealPlanIds) { mealPlanId ->
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text("Meal Plan ID: $mealPlanId", style = MaterialTheme.typography.bodyMedium)
                            if (isOwner) {
                                IconButton(onClick = { viewModel.removeMealPlanFromCollaborativePlan(plan.id, mealPlanId) }) {
                                    Icon(Icons.Default.Delete, contentDescription = "Unlink Meal Plan")
                                }
                            }
                        }
                    }
                    item {
                        if (isOwner) {
                            Spacer(modifier = Modifier.height(16.dp))
                            OutlinedTextField(
                                value = mealPlanToAddId,
                                onValueChange = { mealPlanToAddId = it },
                                label = { Text("Meal Plan ID to Link") },
                                modifier = Modifier.fillMaxWidth()
                            )
                            Spacer(modifier = Modifier.height(8.dp))
                            Button(
                                onClick = {
                                    viewModel.addMealPlanToCollaborativePlan(plan.id, mealPlanToAddId)
                                    mealPlanToAddId = ""
                                },
                                modifier = Modifier.fillMaxWidth(),
                                enabled = mealPlanToAddId.isNotBlank()
                            ) {
                                Text("Link Meal Plan")
                            }
                        }
                    }
                }
            }
        }
    }
}
