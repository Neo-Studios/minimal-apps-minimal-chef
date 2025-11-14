package com.neostudios.zest.data.local

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.neostudios.zest.MainActivity
import com.neostudios.zest.R
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class NotificationManager @Inject constructor(
    @ApplicationContext private val context: Context
) {
    companion object {
        const val CHANNEL_TIMERS = "timers"
        const val CHANNEL_MEAL_REMINDERS = "meal_reminders"
        const val CHANNEL_RECIPE_SUGGESTIONS = "recipe_suggestions"
        const val CHANNEL_SHOPPING = "shopping"
        
        const val NOTIFICATION_ID_TIMER_BASE = 1000
        const val NOTIFICATION_ID_MEAL_REMINDER = 2000
        const val NOTIFICATION_ID_RECIPE_SUGGESTION = 3000
        const val NOTIFICATION_ID_SHOPPING = 4000
    }
    
    init {
        createNotificationChannels()
    }
    
    private fun createNotificationChannels() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channels = listOf(
                NotificationChannel(
                    CHANNEL_TIMERS,
                    "Cooking Timers",
                    NotificationManager.IMPORTANCE_HIGH
                ).apply {
                    description = "Notifications for cooking timers"
                    enableVibration(true)
                    enableLights(true)
                },
                NotificationChannel(
                    CHANNEL_MEAL_REMINDERS,
                    "Meal Reminders",
                    NotificationManager.IMPORTANCE_DEFAULT
                ).apply {
                    description = "Reminders for upcoming meals"
                },
                NotificationChannel(
                    CHANNEL_RECIPE_SUGGESTIONS,
                    "Recipe Suggestions",
                    NotificationManager.IMPORTANCE_LOW
                ).apply {
                    description = "Daily recipe suggestions"
                },
                NotificationChannel(
                    CHANNEL_SHOPPING,
                    "Shopping Lists",
                    NotificationManager.IMPORTANCE_DEFAULT
                ).apply {
                    description = "Shopping list reminders"
                }
            )
            
            val notificationManager = context.getSystemService(NotificationManager::class.java)
            channels.forEach { notificationManager.createNotificationChannel(it) }
        }
    }
    
    fun sendTimerNotification(timerName: String, timerId: Int) {
        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            putExtra("navigate_to", "timers")
        }
        val pendingIntent = PendingIntent.getActivity(
            context,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        
        val notification = NotificationCompat.Builder(context, CHANNEL_TIMERS)
            .setSmallIcon(R.drawable.ic_launcher_foreground)
            .setContentTitle("⏰ Timer Complete!")
            .setContentText("$timerName is done")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setCategory(NotificationCompat.CATEGORY_ALARM)
            .setAutoCancel(true)
            .setContentIntent(pendingIntent)
            .setVibrate(longArrayOf(0, 500, 200, 500))
            .build()
        
        NotificationManagerCompat.from(context)
            .notify(NOTIFICATION_ID_TIMER_BASE + timerId, notification)
    }
    
    fun sendMealReminderNotification(mealName: String, mealTime: String) {
        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            putExtra("navigate_to", "meal_plan")
        }
        val pendingIntent = PendingIntent.getActivity(
            context,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        
        val notification = NotificationCompat.Builder(context, CHANNEL_MEAL_REMINDERS)
            .setSmallIcon(R.drawable.ic_launcher_foreground)
            .setContentTitle("🍽️ Meal Reminder")
            .setContentText("Time for $mealName at $mealTime")
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setAutoCancel(true)
            .setContentIntent(pendingIntent)
            .build()
        
        NotificationManagerCompat.from(context)
            .notify(NOTIFICATION_ID_MEAL_REMINDER, notification)
    }
    
    fun sendRecipeSuggestionNotification(recipeName: String, recipeId: String) {
        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            putExtra("navigate_to", "recipe_detail")
            putExtra("recipe_id", recipeId)
        }
        val pendingIntent = PendingIntent.getActivity(
            context,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        
        val notification = NotificationCompat.Builder(context, CHANNEL_RECIPE_SUGGESTIONS)
            .setSmallIcon(R.drawable.ic_launcher_foreground)
            .setContentTitle("🍳 Recipe Suggestion")
            .setContentText("Try making $recipeName today!")
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setAutoCancel(true)
            .setContentIntent(pendingIntent)
            .build()
        
        NotificationManagerCompat.from(context)
            .notify(NOTIFICATION_ID_RECIPE_SUGGESTION, notification)
    }
    
    fun sendShoppingReminderNotification(itemCount: Int) {
        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            putExtra("navigate_to", "shopping")
        }
        val pendingIntent = PendingIntent.getActivity(
            context,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        
        val notification = NotificationCompat.Builder(context, CHANNEL_SHOPPING)
            .setSmallIcon(R.drawable.ic_launcher_foreground)
            .setContentTitle("🛒 Shopping Reminder")
            .setContentText("You have $itemCount items on your shopping list")
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setAutoCancel(true)
            .setContentIntent(pendingIntent)
            .build()
        
        NotificationManagerCompat.from(context)
            .notify(NOTIFICATION_ID_SHOPPING, notification)
    }
    
    fun cancelNotification(notificationId: Int) {
        NotificationManagerCompat.from(context).cancel(notificationId)
    }
    
    fun cancelAllNotifications() {
        NotificationManagerCompat.from(context).cancelAll()
    }
}
