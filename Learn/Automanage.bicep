param customProfileName string
param location string
param antimalware string = 'true'
@allowed([
  'Quick'
  'Full'
])
param scantype string = 'Quick'
param backup string = 'true'
param changetracking bool = true
param updatemanagement bool = true
param vminsights bool = true
@allowed([
  'ApplyAndAutoCorrect'
  'ApplyAndMonitor'
  'Audit'
])
param azureSecurityBaselineAssignmentType string

resource customProfileName_resource 'Microsoft.Automanage/configurationProfiles@2021-04-30-preview' = {
  name: customProfileName
  location: location
  properties: {
    configuration: {
      'Antimalware/Enable': antimalware
      'Antimalware/EnableRealTimeProtection': antimalware
      'Antimalware/RunScheduledScan': antimalware
      'Antimalware/ScanType': scantype
      'Antimalware/ScanDay': '7'
      'Antimalware/ScanTimeInMinutes': '120'
      'AzureSecurityBaseline/Enable': true
      'AzureSecurityBaseline/AssignmentType': azureSecurityBaselineAssignmentType
      'AzureSecurityCenter/Enable': true
      'Backup/Enable': backup
      'Backup/PolicyName': 'dailyBackupPolicy'
      'Backup/TimeZone': 'UTC'
      'Backup/InstantRpRetentionRangeInDays': '2'
      'Backup/SchedulePolicy/ScheduleRunFrequency': 'Daily'
      'Backup/SchedulePolicy/ScheduleRunTimes': [
        '2017-01-26T00:00:00Z'
      ]
      'Backup/SchedulePolicy/SchedulePolicyType': 'SimpleSchedulePolicy'
      'Backup/RetentionPolicy/RetentionPolicyType': 'LongTermRetentionPolicy'
      'Backup/RetentionPolicy/DailySchedule/RetentionTimes': [
        '2017-01-26T00:00:00Z'
      ]
      'Backup/RetentionPolicy/DailySchedule/RetentionDuration/Count': '180'
      'Backup/RetentionPolicy/DailySchedule/RetentionDuration/DurationType': 'Days'
      'BootDiagnostics/Enable': true
      'ChangeTrackingAndInventory/Enable': changetracking
      'LogAnalytics/Enable': true
      'UpdateManagement/Enable': updatemanagement
      'VMInsights/Enable': vminsights
    }
  }
}
