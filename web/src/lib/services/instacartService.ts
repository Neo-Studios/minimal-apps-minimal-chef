import { ShoppingListItem } from '@/types/models'

export class InstacartService {
  private static readonly INSTACART_BASE_URL = 'https://www.instacart.com'
  
  /**
   * Generate Instacart deep link with shopping list items
   * Note: Instacart doesn't have a public API, so we use deep linking
   */
  static generateInstacartLink(items: ShoppingListItem[]): string {
    // Format items for Instacart search
    const searchQuery = items
      .filter(item => !item.checked)
      .map(item => {
        const amount = item.amount ? `${item.amount} ` : ''
        return `${amount}${item.name}`
      })
      .join(', ')
    
    // Create search URL
    const encodedQuery = encodeURIComponent(searchQuery)
    return `${this.INSTACART_BASE_URL}/store/search?query=${encodedQuery}`
  }
  
  /**
   * Open Instacart with shopping list
   */
  static openInstacart(items: ShoppingListItem[]): void {
    const url = this.generateInstacartLink(items)
    window.open(url, '_blank')
  }
  
  /**
   * Check if Instacart is available (always true for web)
   */
  static isAvailable(): boolean {
    return true
  }
}
