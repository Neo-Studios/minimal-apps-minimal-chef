import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {
  faBook,
  faCalendar,
  faCartShopping,
  faBookBookmark,
  faChartLine,
  faClock,
  faRobot,
  faGear,
  faFire,
  faDrumstickBite,
  faBreadSlice,
  faSeedling,
  faUtensils,
  faTrash,
  faFolder,
  faClipboard,
  faCircleInfo,
  faCircleCheck,
  faTriangleExclamation,
  faCircleXmark,
  faMobileScreen,
  faUsers,
  faLock,
  faPlus,
  faArrowLeft, // Added faArrowLeft
  faMicrophoneSlash, // Added faMicrophoneSlash
  faMicrophone, // Added faMicrophone
  faArrowRight, // Added faArrowRight
  faBox, // Added faBox
} from '@fortawesome/free-solid-svg-icons'

const iconMap = {
  // Navigation
  book: faBook,
  calendar: faCalendar,
  cart: faCartShopping,
  cookbook: faBookBookmark,
  chart: faChartLine,
  clock: faClock,
  robot: faRobot,
  settings: faGear,
  
  // Food & Nutrition
  fire: faFire,
  meat: faDrumstickBite,
  bread: faBreadSlice,
  vegetable: faSeedling,
  utensils: faUtensils,
  
  // Actions
  trash: faTrash,
  folder: faFolder,
  clipboard: faClipboard,
  
  // Status
  info: faCircleInfo,
  success: faCircleCheck,
  warning: faTriangleExclamation,
  error: faCircleXmark,
  
  // Misc
  mobile: faMobileScreen,
  users: faUsers,
  lock: faLock,
  plus: faPlus,
  'arrow-left': faArrowLeft, // Added arrow-left icon
  'microphone-slash': faMicrophoneSlash, // Added microphone-slash icon
  microphone: faMicrophone, // Added microphone icon
  'arrow-right': faArrowRight, // Added arrow-right icon
  box: faBox, // Added box icon
}

export type IconName = keyof typeof iconMap

interface IconProps {
  name: IconName
  className?: string
  size?: 'xs' | 'sm' | 'lg' | 'xl' | '2x' | '3x' | '4x' | '5x' | '6x'
}

export function Icon({ name, className, size }: IconProps) {
  return <FontAwesomeIcon icon={iconMap[name]} className={className} size={size} />
}
